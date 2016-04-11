class FinishActivityController < ApplicationController
  before_action :load_activity, only: [:index]

  def index
    if @activity.finish_activity
      redirect_to project_activity_path(@project, @activity), :flash => { :success => "Atividade Finalizada com Sucesso!" }
    else
      redirect_to project_activity_path(@project, @activity), :flash => { :error => "Você não pode iniciar esta Atividade! A Sprint não está em andamento." }
    end

  end

private
  def load_activity
    load_project
    @activity = @project.activities.find_by_id(params[:activity_id])
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end
