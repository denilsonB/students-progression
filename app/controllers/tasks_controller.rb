class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy update_progress students_progress update_time_spent]
  before_action :set_classroom, only: %i[ show edit update destroy new create students_progress ]
  before_action :set_feedback, only: [:show]
  before_action :set_session_start_time, only: [:show]
  # GET /tasks or /tasks.json
  def index
    @classroom = Classroom.find(params[:classroom_id])
    @tasks = @classroom.tasks
    @task_id_progress = {}
    current_user.task_progresses.pluck(:task_id,:progress).each {|task,progress| @task_id_progress[task]=progress}
  end

  def students_progress
    authorize_teacher!

    @task_id_progress = {}
    @task_id_time_spent = {}
    TaskProgress.where(task_id: @task.id).pluck(:user_id,:progress, :time_spent).each {
      |user,progress,time_spent| 
      @task_id_progress[user] = progress
      @task_id_time_spent[user] = Time.at(time_spent).utc.strftime("%M:%S")
    }
    @students = @classroom.users
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    @task_progress = current_user.task_progresses.find_or_initialize_by(task_id: @task.id)
    @task = Task.find(params[:id])
    @content_chunks = @task.content.split("\n\n") 
    @page = params[:page].to_i == 0 ? @task_progress.last_page_read : params[:page].to_i
    @page = 0 if @page < 0
    update_progress_pagenated
    update_time_spent
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = @classroom.tasks.new(task_params)
    @task.author_id = current_user.id
    if @task.save
      redirect_to classroom_tasks_path(@classroom), notice: "Texto Criada com Sucesso"
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to classroom_tasks_path(@classroom), notice: "Texto Atualizada com Sucesso" }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Texto Excluida." }
      format.json { head :no_content }
    end
  end

  def update_progress

    @task_progress = current_user.task_progresses.find_or_create_by(task_id: @task.id)
    
    return if @task_progress.progress >= params[:progress].to_i
    
    @task_progress.update(progress: params[:progress].to_i) 

    head :no_content
  end

  def update_time_spent
    @task_progress = current_user.task_progresses.find_or_create_by(task_id: @task.id)
    @task_progress.add_time_spent(params[:time_spent].to_i)

    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      task_id = params[:task_id] || params[:id]
      @task = Task.find(task_id)
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :content, :grade_level)
    end

    def set_classroom
      @classroom = Classroom.find(params[:classroom_id])
    end

    def set_feedback
      @feedback = @task.feedbacks.new
    end

    def authorize_teacher!
      unless current_user.user_type == 'Professor'
        redirect_to classroom_tasks_path(@classroom), alert: 'Access denied.'
      end
    end

    def update_progress_pagenated
      progress = ((@page + 1).to_f / @content_chunks.size * 100).round(2)
      @task_progress.update(progress: progress,last_page_read: @page) if progress >= @task_progress.progress
    end

    def update_time_spent
      time_spent = Time.current.to_i - session[:start_time]
      time_spent = 0 if time_spent < 0
      
      session[:start_time] = Time.current.to_i
      @task_progress.update(time_spent: @task_progress.time_spent + time_spent)
    end

    def set_session_start_time
      session[:start_time] = Time.current.to_i unless session[:start_time]
    end
end
