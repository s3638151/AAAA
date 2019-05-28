class HomeController < ApplicationController
  def index
    if session.include?(:user_id)
      redirect_to courses_path
    end
  end

  def sendemail
    @name = params[:name]
    @message = params[:message]

    ContactUsMailer.contactus(@name, @message).deliver
    flash[:success] = "Email has been sent."

    redirect_back fallback_location: root_path
  end
end
