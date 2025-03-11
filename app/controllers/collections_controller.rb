class CollectionsController < ApplicationController
  def index
    @collections = Collection.all
    @collection = Collection.new
  end

  def create
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
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description)
  end
end
