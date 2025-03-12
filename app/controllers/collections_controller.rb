class CollectionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def index
    @collections = Collection.all
    @collection = Collection.new
  end

  def create
    @collections = Collection.all
    @collection = Collection.new(collection_params)
    @collection.user = current_user

    if @collection.save
      redirect_to collection_path(@collection), notice: "success"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @collection = Collection.find(params[:id])
    @properties = Property.all
    @collection.user = current_user
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description)
  end
end
