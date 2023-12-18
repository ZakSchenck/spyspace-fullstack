class Api::V1::RepliesController < ApplicationController
    before_action :set_post

    def create
      @reply = @post.replies.build(body: params[:body])

      if @reply.save
        render json: @reply, status: :created
      else
        render json: @reply.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def reply_params
      params.require(:reply).permit(:body)
    end
  end