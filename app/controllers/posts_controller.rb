class PostsController < ApplicationController

  def new
    @post = Post.new(sub_id: params[:sub_id])
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    url = @post.url

    @post.url = "http://" + url unless (url[0..6] == "http://") || (url[0..7] == "https://")

    if @post.save
      PostSub.create(post_id: @post.id, sub_id: params[:sub_id])
      redirect_to sub_post_url(id: @post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post_sub = PostSub.find_by(post_id: params[:id], sub_id: params[:sub_id])
    @post = Post.find(@post_sub.post_id)

    render :show
  end

  def destroy
    @post_sub = PostSub.find_by(post_id: params[:id], sub_id: params[:sub_id])
    @post_sub.destroy
    redirect_to sub_url(Sub.find(params[:sub_id]))
  end

  def edit
    @post_sub = PostSub.find_by(post_id: params[:id], sub_id: params[:sub_id])
    @post = Post.find(@post_sub.post_id)
    render :new
  end

  def update
    @post_sub = PostSub.find_by(post_id: params[:id], sub_id: params[:sub_id])
    @post = Post.find(@post_sub.post_id)
    if @post.update(post_params)
      redirect_to sub_post_url(id: @post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end


  def xpost_new
    @post = Post.find(params[:post_id])
    render :xpost_new
  end

  def xpost
    sub_id = Sub.find_by_title(params[:x_post][:sub]).id
    @post_sub = PostSub.new(sub_id: sub_id, post_id: params[:post_id])

    if @post_sub.save
      redirect_to sub_post_url(id: params[:post_id], sub_id: sub_id)
    else
      flash.now[:errors] = @post_sub.errors.full_messages
      render :xpost_new
    end

  end

  private
  def post_params
    post_params = params.require(:post).permit(:title, :url, :content)
    post_params.merge(sub_id: params[:sub_id])
  end
end
