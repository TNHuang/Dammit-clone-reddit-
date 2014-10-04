class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)
    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to sub_post_url(sub_id: params[:sub_id], id: params[:post_id])
  end

  def destroy
  end

  private
  def comment_params
    comment_params = params.require(:comment).permit(:content)
    comment_params.merge(post_id: params[:post_id], parent_comment_id: params[:parent_comment_id])
  end

end
