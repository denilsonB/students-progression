class FeedbacksController < ApplicationController
  before_action :set_classroom
  before_action :set_task

  def index
    @feedbacks = @task.feedbacks
  end

  def create
    @feedback = @task.feedbacks.new(feedback_params)
    if @feedback.save
      redirect_to classroom_tasks_path(@classroom), notice: "Feedback submitted successfully"
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
    params.require(:feedback).permit(:note).merge(user_id: current_user.id)
  end
end