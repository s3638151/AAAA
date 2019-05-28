class CoursesController < ApplicationController

  before_action :authorized, only: ['create', 'edit', 'thumbs_up', 'thumbs_down', 'new', 'update', 'reset_votes', 'destroy']

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def create
    image = params[:course][:image]
    path = nil

    if image = nil
      path = File.join('uploads', image.original_filename)
      FileUtils.move File.join('public', path), path
    end

    @course = Course.new(params.require(:course).permit(:name,:prerequisite,:description))
    @course.image = path
    @course.user_id = session[:user_id]

    if @course.save()
      categories = params[:course][:categories]
      categories.each do |item|
        if item != '0'
          @course.categories << Category.find(item)
        end
      end

      locations = params[:course][:locations]
      locations.each do |item|
        if item != '0'
          @course.locations << Location.find(item)
        end
      end

      redirect_to @course
    else 
      referer = request.referer.gsub(/\?.*/, "")
      return redirect_to referer, :flash => { :errors => @course.errors}
    end
  end

  def thumbs_up
    @course = Course.find(params[:course_id])
    
    if @course.votes.where(:user_id => session[:user_id]).count == 0
      @course.votes.create(vote: 1, user_id: session[:user_id])
    else
      flash[:danger] = "You can vote this course once only!"
    end
    
    redirect_back fallback_location: root_path
  end

  def thumbs_down
    @course = Course.find(params[:course_id])

    if @course.votes.where(:user_id => session[:user_id]).count == 0
      @course.votes.create(vote: 0, user_id: session[:user_id])
    else
      flash[:danger] = "You can vote this course once only!"
    end
    
    redirect_back fallback_location: root_path
  end

  def edit
    @course = Course.find(params[:id])

    if !current_user.is_admin? && @course.user != current_user
      flash[:danger] = "You are not authorized to edit this courses."

      redirect_back fallback_location: root_path
    end
  end

  def update
    image = params[:course][:image]
    path = nil

    if image = nil
      path = File.join('uploads', image.original_filename)
      FileUtils.move File.join('public', path), path
    end

    @course = Course.find(params[:id])
    @course.image = path
    @course.user_id = session[:user_id]

    if @course.update(params.require(:course).permit(:name,:prerequisite,:description))
      categories = params[:course][:categories]
      categories.each do |item|
        if item != '0'
          @course.categories << Category.find(item)
        end
      end

      locations = params[:course][:locations]
      locations.each do |item|
        if item != '0'
          @course.locations << Location.find(item)
        end
      end

      redirect_to @course
    else 
      referer = request.referer.gsub(/\?.*/, "")
      return redirect_to referer, :flash => { :errors => @course.errors}
    end
  end

  def reset_votes
    @course = Course.find(params[:course_id])
    @course.votes.clear

    redirect_back fallback_location: root_path
  end

  def destroy
    if !current_user.is_admin?
      flash[:danger] = "You are not authorized to edit this courses."

      redirect_back fallback_location: root_path
    end

    Course.destroy(params[:id])
    redirect_back fallback_location: root_path
  end

  def api_course
    @course = Course.find(params[:id])

    render json: @course
  end

  def api_courses
    @courses = Course.all

    render json: @courses
  end
end
