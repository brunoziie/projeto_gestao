class StartSprintController < ApplicationController
  before_action :load_sprint, only: [:index]

  def index
    @sprint.start_sprint

    redirect_to project_sprint_path(@project, @sprint), :flash => { :success => "Sprint Iniciada com Sucesso!" }
  end

private
  def load_sprint
    load_project
    @sprint = @project.sprints.find_by_id(params[:sprint_id])
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end
