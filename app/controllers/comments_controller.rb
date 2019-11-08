class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @comment = current_user.comments.build comment_params
    flash[:danger] = t "msg.comment_fail" unless @comment.save
    redirect_to review_path
  end

  def destroy
    if @comment.destroy
      flash[:success] = t "msg.comment_delete_success"
    else
      flash[:danger] = t "msg.comment_delete_fail"
    end
    redirect_to request.referrer || review_path
  end

  private

  def comment_params
    params.require(:comment).permit :content, :comment_type, :comment_id,
      :parent_id
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    return if @comment
    flash[:danger] = t "msg.comment_delete_fail"
    redirect_to review_path
  end
end
