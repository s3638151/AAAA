class UserController < ApplicationController

  before_action :authorized, only: ['edit', 'destroy', 'update']
  
  def login
  end

  def login_post
    if params[:user][:email].blank?
      flash[:errors] = {:email => ["can't be blank"]}
    end

    if params[:user][:password].blank?
      flash[:errors] = {:password => ["can't be blank"]}
    end

    if flash.any?
      return render 'user/login'
    end

    user = User.find_by_email(params[:user][:email])

    if user && user.authenticate(params[:user][:password])
      flash[:success] = 'login successfully'
      session[:user_id] = user.id
      redirect_to courses_path
    else
      flash[:errors] = {:account => ["not found or enter a wrong password."]}
      return render 'user/login'
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password))
    if @user.save()
      session[:user_id] = @user.id

      redirect_to :root
    else
      referer = request.referer.gsub(/\?.*/, "")
      redirect_to referer, :flash => { :errors => @user.errors}
    end
    
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])

    if !current_user.is_admin? && @user != current_user
      flash[:danger] = "You are not authorized to edit this courses."

      redirect_back fallback_location: root_path
    end
  end

  def update
    @user = User.find(params[:id])

    if !current_user.is_admin? && @course.user != current_user
      flash[:danger] = "You are not authorized to edit this courses."

      redirect_back fallback_location: root_path
    end

    @user.update(params.require(:user).permit(:name, :email, :password))
    redirect_back fallback_location: root_path
  end

  def index
    @users = User.where(:types => 0).all
  end

  def destroy
    if !current_user.is_admin?
      flash[:danger] = "You are not authorized to edit this courses."

      redirect_back fallback_location: root_path
    end

    User.destroy(params[:id])
    redirect_back fallback_location: root_path
  end

  def logout
    session.delete(:user_id)
    render 'user/logout'
  end

  def api_user
    @user = User.find(params[:id])

    render json: @user
  end

  def api_users
    @users = User.all
    
    render json: @users
  end
end
