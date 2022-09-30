class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :ensure_user_logged_in
    
    def ensure_user_logged_in
        redirect_to root_path unless current_user
      end

    private   
    
    def current_user   
      User.where(id: session[:user_id]).first   
    end   
    helper_method :current_user   
end
