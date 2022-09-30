class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  def new
  end

  def create   
    user = User.find_by_email(params[:email])   
    if user && user.authenticate(params[:password]) 
      if user.email_confirmed
        session[:user_id] = user.id 
        @login_count = LoginCounter.find_by(user_id: user.id)
        if @login_count == nil
          login_new = LoginCounter.new(no_of_logins: 1, user_id: user.id)
          if login_new.save
            puts "Saved"
          else
            puts "Not Saved"
          end
        else
          @logged_in_user = LoginCounter.find_by(user_id: user.id)
          if @logged_in_user.update(no_of_logins: @logged_in_user.no_of_logins.to_i + 1)
            puts "Updated"
          else
            puts "Not Updated"
          end
        end
          if user.role == 'Manager'
            redirect_to manager_path
          else
            redirect_to interviwee_path
          end
        else
            flash.now[:error] = 'Please activate your account by following the instructions in the account confirmation email you received to proceed'
            render 'new'
        end  
      # redirect_to interviwee_path, notice: 'Logged in!'   
    else   
      render :new   
    end   
  end   
  def destroy   
    session[:user_id] = nil   
    redirect_to login_path, notice: 'Logged out!'   
  end   
end
