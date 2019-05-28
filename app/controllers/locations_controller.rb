class LocationsController < ApplicationController
    before_action :authorized, only: ['create', 'edit', 'destroy', 'new', 'update']
    
    def create
        @location = Location.new(params.require(:location).permit(:name))

        if @location.save()
            redirect_to @location
        else 
            referer = request.referer.gsub(/\?.*/, "")
            redirect_to referer, :flash => { :errors => @location.errors}
        end
    end

    def show
        @location = Location.find(params[:id])
    end
end
