class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:messages] = ["Comment Saved!"]
      redirect_to post_url(params[:comment][:post_id])
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to post_url(params[:comment][:post_id])
    end
  end

  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id, :post_id)
  end

end
