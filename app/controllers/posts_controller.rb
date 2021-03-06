class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: :destroy
  def index
    @posts = Post.paginate(page: params[:page])
  end
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "post created!"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post.update_attributes(article_params)
      flash[:success] = "Article updated"
      redirect_to @uarticle
    else
      render 'edit'
    end
  end
  def destroy
    @post.destroy
    flash[:success] = "post deleted"
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
