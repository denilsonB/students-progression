class ClassroomsController < ApplicationController
  before_action :set_classroom, only: %i[ show edit update destroy classroom_students]

  # GET /classrooms or /classrooms.json
  def index
    @classrooms = current_user.user_type == 'Aluno' ? current_user.classrooms : Classroom.where(author_id:current_user.id)
  end

  # GET /classrooms/1 or /classrooms/1.json
  def show
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
  end

  # GET /classrooms/1/edit
  def edit
  end

  # POST /classrooms or /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)
    @classroom.author_id = current_user.id

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to classrooms_path, notice: "Turma Criada com Sucesso." }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1 or /classrooms/1.json
  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to classrooms_path, notice: "Turma Atualizada com Sucesso." }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1 or /classrooms/1.json
  def destroy
    @classroom.destroy

    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: "Turma Excluida com Sucesso." }
      format.json { head :no_content }
    end
  end

  def classroom_students
    @students = @classroom.users
  end 

  private

    def set_classroom
      @classroom = params[:id].nil? ? Classroom.find(params[:classroom_id]) : Classroom.find(params[:id])
    end

    def classroom_params
      params.require(:classroom).permit(:name, :author_id)
    end
end
