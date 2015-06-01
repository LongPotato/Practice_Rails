class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Private Events!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @previous_events = @user.previous_events
    @upcoming_events = @user.upcoming_events
  end

  private

    def user_params
      params.require(:user).permit(:name, :email)
    end
end
