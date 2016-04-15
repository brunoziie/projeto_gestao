class ActivitiesController < ApplicationController

  def index
    load_project

    add_breadcrumb @project.name, "/projects/#{@project.id}"

    @activities = @project.backlog_activities
  end

  def new
    load_sprints

    @activity = Activity.new(sprint_id: params[:sprint_id])

    add_breadcrumb @project.name, "/projects/#{@project.id}"
    if params[:sprint_id].blank?
      add_breadcrumb "Atividades em Backlog", "/projects/#{@project.id}/activities"
    else
      add_breadcrumb "SPRINT ##{@activity.sprint.number}", "/projects/#{@project.id}/sprints/#{@activity.sprint.id}"
    end

    authorize @project
  end

  def create
    load_project

    @sprint = @project.sprints.find_by_id(params[:activity][:sprint_id])

    if @sprint.blank?
      params[:activity][:sprint_id] = nil
      @activity = @project.activities.new(activity_params)
    else
      @activity = @sprint.activities.new(activity_params)
      @activity.project = @project
      @activity.status = ProgressActivityStatus::WAITING
      @activity.create_historical HistoricalType::CREATED, current_user
    end

    if @activity.save
      flash[:success] = "Atividade Criada com Sucesso!"
      redirect_to [@project, @activity]
    else
      render 'new'
    end

    authorize @project
  end

  def show
    load_project

    @activity = Activity.find(params[:id])
    @comment = Comment.new
    @historicals = @activity.historicals.order(:timetable)

    add_breadcrumb @project.name, "/projects/#{@project.id}"
    add_breadcrumb "SPRINT ##{@activity.sprint.number}", "/projects/#{@project.id}/sprints/#{@activity.sprint.id}"

    authorize @project
  end

 private
    def load_sprints
      load_project
      @sprints = @project.sprints.order(:number)
    end

    def load_project
      @project = Project.find(params[:project_id])
    end

    def activity_params
      params.require(:activity).permit(:name, :description, :estimate,:sprint_id)
    end
end

