class CommentsController < ApplicationController
  def create
    @property = Property.find(params[:property_id])
    @comment = Comment.new(comment_params)
    @comment.property = @property
    @comment.user = current_user
    @collection = @property.collection

    if @comment.save
      create_event(:comment_creation)
      redirect_to collection_path(@property.collection)
    else
      redirect_to collection_path(@property.collection)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def create_event(event_type)
    Event.create(
      user_id: current_user.id,
      property: @property,
      comment_text: @comment.text,
      comment_id: @comment.id,
      user_first_name: current_user.first_name,
      user_last_name: current_user.last_name,
      property_name: @property.name,
      url: @property.url,
      collection_name: @collection.name,
      collection_url: "/collections/#{@collection.id}",
      event_type: event_type
    )
  end
end
