class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    def not_found
        return redirect_to '/404.html'
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def authorized
        redirect_to 'user/login' unless current_user
    end
end
