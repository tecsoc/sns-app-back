class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  
  private

  def render_404
    render json: { error: 'Not Found' }, status: :not_found
  end
end
