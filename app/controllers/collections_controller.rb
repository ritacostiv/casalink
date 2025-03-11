class CollectionsController < ApplicationController
  def index
    @collections = Collection.all
  end

  def new
  end

  def create
    @collection = Collection.new(collection_params)

    if @collection.save
      redirect_to collections_path, notice: "success"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description)
  end
end
