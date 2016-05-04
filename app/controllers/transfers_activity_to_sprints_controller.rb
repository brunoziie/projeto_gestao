class TransfersActivityToSprintsController < ApplicationController

  def new
    load_activity

    authorize @project
  end

  def create
    load_activity

    @activity.sprint_id = params[:activity][:sprint_id]
    @activity.status = ProgressActivityStatus::WAITING if @activity.status.nil?

    if @activity.save
      flash[:success] = "Atividade Transferida com Sucesso!"
      redirect_to project_activities_path
    else
      render 'new'
    end

    authorize @project
  end

private
  def load_activity
    load_sprints

    @activity = @project.activities.find(params[:activity_id])
  end

  def load_sprints
    load_project

    @sprints = @project.sprints.order(:number)
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end
