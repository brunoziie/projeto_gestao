class ParticipationsController < ApplicationController
  before_action :load_project, only: [:index, :destroy, :create]

  def index
    @free_users = @project.free_users - [current_user]

    add_breadcrumb @project.name, "/projects/#{@project.id}"

    authorize @project
  end

  def destroy
    user = @project.users.find_by_id(params[:id])

    if @project.users.delete(user)
      flash[:success] = "Participante Removido com Sucesso!"
      redirect_to project_participations_path(@project)
    else
      render 'index'
    end

    authorize @project
  end

  def create
    user = User.find(params[:project][:id])

    if user.projects << @project
      flash[:success] = "Participante Adicionado com Sucesso!"
      redirect_to project_participations_path(@project)
    else
      render 'index'
    end

    authorize @project
  end

private
  def load_project
    @project = Project.find(params[:project_id])
  end
end
