class SignupController < ApplicationController
  def create
        # Check if the email or username already exists
    if User.exists?(email: user_params[:email])
      return render json: { error: 'Email already exists' }, status: :unprocessable_entity
    elsif User.exists?(username: user_params[:username])
      return render json: { error: 'Username already exists' }, status: :unprocessable_entity
    end

    user = User.new(user_params)

    if user.save
      payload = { user_id: user.id  }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login

      response.set_cookie(JWTSessions.access_cookie, value: tokens[:access], httponly: true, secure: Rails.env.production?)

      render json: {csrf: tokens[:csrf]}
    else 
      render json: { error: user.errors.full_message.join(' ') }, status: :unprocessable_entity
    end 
  end

  private
 
  def user_params
    params.permit(:email, :username, :password, :password_confirmation)
  end
end
