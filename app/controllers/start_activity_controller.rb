class StartActivityController < ApplicationController
  before_action :load_activity, only: [:index]

  def index
    @activity.start_activity

    redirect_to project_activity_path(@project, @activity), :flash => { :success => "Atividade Iniciada com Sucesso!" }
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
