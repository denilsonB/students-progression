class StudentsController < ApplicationController
  def create
    @classroom = Classroom.find(params[:classroom_id])
    student = User.find(params[:user_id])

    @classroom.users << student 
    redirect_to classroom_classroom_students_path(@classroom), notice: "Aluno adicionado com sucesso!" if @classroom.save
  end
end
