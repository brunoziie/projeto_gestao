class SprintsController < ApplicationController
  before_action :load_sprint, only: [:edit, :show, :update, :destroy]

  def show
    @activities = @sprint.activities
  end

  def new
    load_project
    @sprint = Sprint.new

    authorize @project
  end

  def create
    load_project
    @sprint = Sprint.new(sprint_params)
    @sprint.project = @project

    if @sprint.save
      flash[:success] = "Projeto Criado com Sucesso!"
      redirect_to [@project, @sprint]
    else
      render 'new'
    end

    authorize @project
  end

  def destroy
    if @sprint.destroy
      flash[:success] = "Sprint Excluída com Sucesso!"
      redirect_to project_path(@project)
    else
      render @sprint
    end

    authorize @project
  end

 private
    def load_sprint
      load_project
      @sprint = @project.sprints.find_by_id(params[:id])
    end

    def load_project
      @project = Project.find(params[:project_id])
    end

    def sprint_params
      params.require(:sprint).permit(:description, :init_date, :end_date)
    end
end
