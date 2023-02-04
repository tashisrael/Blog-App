class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.where(id: params[:user_id]).first
    @comments = Comment.all
    @like = Like.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.all
  end

  def new
    @post = Post.new
  end

  def create
    puts params
    author = current_user
    new_post = Post.new(post_params)
    new_post.author = author
    if new_post.save
      redirect_to user_posts_path(id: author.id)
    else
      redirect_to user_posts_path(user_id: author.id)
    end
  end

  def post_params
    params.require(:post).permit(:Title, :Text)
  end
end
