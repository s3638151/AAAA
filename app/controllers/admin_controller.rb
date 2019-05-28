class AdminController < ApplicationController

  before_action :authorized

  def index
    @courses = Course.all
  end

  def coordinators
    @users = User.all
  end

  def categories
    @categories = Category.all
  end
end
