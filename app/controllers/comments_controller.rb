class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    
    if @comment.save
      redirect_to @post, notice: "Comment added."
    else
      redirect_to @post, alert: "Comment can't be blank."
    end
  end

def update
  @post = Post.find(params[:post_id])
  @comment = @post.comments.find(params[:id])
  
  if @comment.update(comment_params)
    redirect_to post_path(@post), notice: "Comment updated."
  else
    render :edit, status: :unprocessable_entity
  end
end

def edit
  @post = Post.find(params[:post_id])
  @comment = @post.comments.find(params[:id])
end


  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    redirect_to @post, notice: "Comment deleted."
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
