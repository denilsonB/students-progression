class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy update_progress]
  before_action :set_classroom, only: %i[ show edit update destroy new create]
  before_action :set_feedback, only: [:show]

  # GET /tasks or /tasks.json
  def index
    @classroom = Classroom.find(params[:classroom_id])
    @tasks = @classroom.tasks
    @task_id_progress = {}
    current_user.task_progresses.pluck(:task_id,:progress).each {|task,progress| @task_id_progress[task]=progress}
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    @task_progress = current_user.task_progresses.find_or_initialize_by(task_id: @task.id)
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
      redirect_to @classroom, notice: "Task created successfully"
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
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
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_progress
    @task_progress = current_user.task_progresses.find_or_initialize_by(task_id: @task.id)
    @task_progress.update(progress: params[:progress]) 
    
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
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
end
