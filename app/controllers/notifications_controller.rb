class NotificationsController < ApplicationController
  def index
    @tasks = Task.joins(:classroom)
                 .where(classrooms: { id: current_user.classroom_ids }) # ou outra lógica
                 .due_today_or_tomorrow
                 .where.not(id: TaskProgress.where(user_id: current_user.id, progress: 100).pluck(:task_id))
  end
end