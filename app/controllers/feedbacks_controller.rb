class FeedbacksController < ApplicationController
  before_action :set_classroom
  before_action :set_task

  def index
    @feedbacks = @task.feedbacks
  end

  def create
    @feedback = @task.feedbacks.new(feedback_params)
    @task_progress = TaskProgress.find_by(user_id:current_user.id,task_id:@task.id)
    @task_progress.progress = 100
    if @feedback.save
      @task_progress.save!
      redirect_to classroom_tasks_path(@classroom), notice: "Feedback Submetido com Sucesso"
    else
      render 'tasks/show' # Render the show template if validation fails
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_classroom
    @classroom = Classroom.find(params[:classroom_id])
  end

  def feedback_params
    params.require(:feedback).permit(:note,:comment).merge(user_id: current_user.id)
  end
end