class CommentsController < ApplicationController
  def create
    @property = Property.find(params[:property_id])
    @comment = Comment.new(comment_params)
    @comment.property = @property
    @comment.user = current_user

    if @comment.save
      redirect_to collection_path(@property.collection), notice: "Comment Added"
    else
      redirect_to collection_path(@property.collection), alert: "Failed to add comment"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
