class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]
  
  def new
  end

  def create
    session_params = params.permit(:email, :password)
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to classrooms_path 
    else
      flash[:notice] = "Login invalido"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to classrooms_path, notice: 'Logged out com Sucesso'
  end
end
