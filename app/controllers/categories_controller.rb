class CategoriesController < ApplicationController

    before_action :authorized, only: ['create', 'edit', 'destroy', 'new', 'update']

    def create
        @category = Category.new(params.require(:category).permit(:name))

        if @category.save()
            redirect_to @category
        else 
            referer = request.referer.gsub(/\?.*/, "")
            redirect_to referer, :flash => { :errors => @category.errors}
        end
    end

    def show
        @category = Category.find(params[:id])
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])
        @category.update(params.require(:category).permit(:name))
    end

    def destroy
        Category.destroy(params[:id])

        redirect_back fallback_location: root_path
    end
end
