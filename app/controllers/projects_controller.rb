class ProjectsController < ApplicationController
  before_action :load_project, only: [:edit, :show, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Projeto Criado com Sucesso!"
      redirect_to @project
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = "Projeto Atualizado com Sucesso!"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = "Projeto Excluído com Sucesso!"
      redirect_to projects_path
    else
      render @project
    end
  end

  private
    def load_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
