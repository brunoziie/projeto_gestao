class CreateCommentsController < ApplicationController
  before_action :load_activity

  def create
    @comment = Comment.new comment_params

    @comment.activity = @activity
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Comentário Enviado com Sucesso!"
      redirect_to [@project, @activity]
    else
      render project_activity_path(@project, @activity)
    end

    authorize @project
  end

 private
    def load_activity
      load_project

      @activity = @project.activities.find(params[:activity_id])
    end

    def load_project
      @project = Project.find(params[:project_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

end
