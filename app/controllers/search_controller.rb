class SearchController < ApplicationController
  def index
    @query = params[:query]

    if @query.present?
      # Global search in all collections
      @collections = Collection.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%")

      # Search within a specific collection (if provided via collection_id param)
      if params[:collection_id]
        @current_collection = Collection.find(params[:collection_id])
        @properties = @current_collection.properties.where("LOWER(name) LIKE ? OR LOWER(address) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%")
      else
        # Global property search across all collections
        @properties = Property.where("LOWER(name) LIKE ? OR LOWER(address) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%")
      end
    else
      # Empty search results if no query is provided
      @collections = []
      @properties = []
    end
  end
end
