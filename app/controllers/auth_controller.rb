class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  # サインアップ（保存に成功したら自動ログインとして cookie に JWT をセット）
  def signup
    user = User.new(user_params)

    if user.save
      login_user(user.id)
      render json: { user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_content
    end
  end

  # ログイン（認証に成功したら cookie に JWT をセット）
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      login_user(user.id)
      render json: { user: user }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # ログアウト（cookie を消す）
  def logout
    cookies.delete(:token, cookie_options)
    render json: { message: 'logged out' }
  end

  # ログイン状態を返す（cookie の JWT を検証）
  def me
    if current_user
      render json: current_user
    else
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :screen_name, :password, :password_confirmation)
  end

  # cookie にトークンをセット（HttpOnly + SameSite）
  def set_token_cookie(token)
    cookies.encrypted[:token] = cookie_options.merge(value: token)
  end

  def login_user(user_id)
    token = JsonWebToken.encode(user_id: user_id)
    set_token_cookie(token)
  end

  # cookie オプションを一箇所にまとめる
  def cookie_options
    {
      value: nil, # set_token_cookie で上書き
      httponly: true,
      secure: Rails.env.production?, # 本番では true に
      same_site: :lax,
      expires: 24.hours.from_now
    }
  end
end
