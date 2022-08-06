class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    if params[:id] == current_user.id
      @user = User.find(params[:id])
      render action: :edit
    else
      @user = current_user
      render action: :edit
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_url(current_user)) unless @user == current_user
  end
end
