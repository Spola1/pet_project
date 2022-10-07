class UsersController < ApplicationController
  before_action :require_no_authentication, only: [:new, :create]
  before_action :require_authentication, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update, :show]
  before_action :authorize_user!
  after_action :verify_authorized

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your profile was successfully updated!'
      redirect_to(root_path)
    else
      render(:edit)
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome on board, dear #{@user.nickname.capitalize}!"
      redirect_to(root_path)
    else
      render(:new)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :nickname, :name, :password, :password_confirmation, :old_password)
  end

  def authorize_user!
    authorize(@user || User)
  end
end
