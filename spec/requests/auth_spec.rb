require 'rails_helper'

RSpec.describe "Auths", type: :request do

  describe "POST /signup" do
    it "returns http success" do
      params = attributes_for(:user)
      post "/signup" , params: params
      expect(response).to have_http_status(:success)

      # Cookie がセットされているか
      expect(response.cookies["token"]).to be_present

      # レスポンスの email が params の email と一致
      json = JSON.parse(response.body)
      expect(json["user"]["email"]).to eq(params[:email])
    end

    it "returns errors when invalid" do
      post "/signup", params: { email: "", password: "x" }
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "POST /login" do
    it "logs in using factory user and sets cookie" do
      params = attributes_for(:user)
      post "/signup" , params: params

      expect(response).to have_http_status(:created)
      expect(response.cookies["token"]).to be_present

      json = JSON.parse(response.body)
      expect(json["user"]["email"]).to eq(params[:email])
    end

    it "returns 401 for wrong password" do
      user = create(:user)
      post "/login", params: { email: user.email, password: "wrong" }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /me" do
    it "returns current user using cookie" do
      params = attributes_for(:user)
      post "/signup" , params: params

      cookies[:token] = response.cookies["token"]
      get "/me"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["email"]).to eq(params[:email])
    end

    it "returns 401 without cookie" do
      get "/me"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "DELETE /logout" do
    before do
      # ログインして cookie をセット
      user = create(:user)
      post "/login", params: { email: user.email, password: user.password }
      expect(response.cookies['token']).to be_present
    end

    it "ログアウトして cookie が削除される" do
      delete "/logout"

      expect(response).to have_http_status(:ok)

      # cookie が削除されていること
      expect(response.cookies['token']).to be_nil
    end
  end
end
