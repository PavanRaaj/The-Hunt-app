class PasswordResetsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  # checks the email and call send_password_reset method in User model
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:notice] = 'E-mail sent with password reset instructions.'
    redirect_to new_session_path
  end
 

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  # check expiry of password reset and upadte with new password
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hour.ago
      flash[:notice] = 'Password reset has expired'
      redirect_to new_password_reset_path
    elsif @user.update(user_params)
      flash[:notice] = 'Password has been reset!'
      redirect_to new_session_path
    else
      render :edit
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:password)
    end
end
