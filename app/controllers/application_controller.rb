class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  
  private

  def render_404
    render json: { error: 'Not Found' }, status: :not_found
  end

  # current_user を取得するヘルパー
  def current_user
    return @current_user if defined?(@current_user)

    token = cookies.encrypted[:token]
    decoded = JsonWebToken.decode(token) if token
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
  end

  def login_required
    render json: { error: "Not authorized" }, status: :unauthorized unless current_user
  end
end
