class PasswordResetsController < ApplicationController
  before_action :require_no_authentication
  before_action :check_user_params, only: %i[edit update]
  before_action :set_user, only: %i[edit update]

  def create
    @user = User.find_by email: params[:email]

    if @user.present?
      @user.set_password_reset_token

      PasswordResetMailer.with(user: @user).reset_email.deliver_later
      flash[:success] = 'The email has been sent to the specified email address'
      redirect_to new_session_path
    else
      flash[:danger] = 'User not found'
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = 'Password updated'
      redirect_to new_session_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation).merge(admin_edit: true)
  end

  def check_user_params
    redirect_to(new_session_path, flash: { warning: 'User not found' }) if params[:user].blank?
  end

  def set_user
    @user = User.find_by email: params[:user][:email],
                         password_reset_token: params[:user][:password_reset_token]

    redirect_to(new_session_path, flash: { warning: 'Token has expired, try again' }) unless @user&.password_reset_period_valid?
  end
end