class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      sign_in user
      flash[:success] = "Welcome back, dear #{current_user.nickname.capitalize}!"
      redirect_to root_path
    else
      flash.now[:warning] = "Incorrect email or password"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "See you later!"
    redirect_to root_path
  end
end
