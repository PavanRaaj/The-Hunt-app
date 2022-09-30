class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :ensure_user_logged_in

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
     
    if @user.save
      UserMailer.registration_confirmation(@user).deliver_now
      # session[:user_id] = @user.id 
      redirect_to login_path, notice: 'User was successfully created.'
    else
      render :new
      # redirect_to root_path
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to interviwee_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the The Hunt! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:user_name, :contact_number, :email, :password, :password_confirmation, :role)
    end
end
