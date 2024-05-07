class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def show
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    p '---------========'
    p user_params
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to task_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :grade_level)
  end
end