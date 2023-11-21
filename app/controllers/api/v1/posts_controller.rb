class Api::V1::PostsController < ApplicationController

  before_action :authorize_access_request!, except: [:show_specific_user_posts, :index]
  before_action :set_post, only: %i[show update destroy]
  

  # GET all posts
  def index
    @posts = Post.all
    render json: @posts, include: :replies
  end

  def show_specific_user_posts
    user = User.find_by(username: params[:username])
    if user
      posts = user.posts.includes(:replies)
      render json: posts, include: :replies
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

    # GET /posts/1 single post
def show
  render json: @post, include: :replies
end

  # Get all posts from your profile
  def current_user_posts
    @posts = current_user.posts.all
    render json: @posts, include: :replies
  end

  # POST /posts
def create
  @post = current_user.posts.build(post_params)
  if @post.save
    render json: @post, status: :created
  else
    render json: @post.errors, status: :unprocessable_entity
  end
end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
