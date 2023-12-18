class Api::V1::PostsController < ApplicationController

  before_action :authorize_access_request!, except: [:show_specific_user_posts, :index, :show]
  before_action :set_post, only: %i[show update destroy]
  
  def show_specific_user_posts
    username = params[:username].strip 
      
    user = User.find_by(username: username)
    if user
      posts = user.posts.includes(:replies)
      render json: posts.as_json(include: { replies: {}, user: { only: [:id, :username, :profile_picture] } })
    else
      render json: { error: "User not found: #{user}" }, status: :not_found
    end
  end
  
  def index
    @posts = Post.includes(:replies, :user).all
    render json: @posts.as_json(include: { replies: {}, user: { only: [:id, :username, :profile_picture] } })  
  end

  # GET /posts/1 single post
def show
  render json: @post.as_json(include: { replies: {}, user: { only: [:id, :username, :profile_picture] } })  
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
    params.require(:post).permit(:body)
  end
end
