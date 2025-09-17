require "rails_helper"

RSpec.describe 'Post', type: :request do
  describe 'index' do
    before do
      @post1 = create(:post, content: "最初の投稿")
      @post2 = create(:post, content: "二つ目の投稿")
    end
    it '正常系' do 
      get posts_url
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)["posts"]
      expect(json).to be_an(Array)
      expect(json.size).to eq 2
      expect(json[0]["content"]).to eq @post1.content
      expect(json[1]["content"]).to eq @post2.content
    end
  end
end
# class PostsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @post = posts(:one)
#   end

#   test "should get index" do
#     get posts_url
#     assert_response :success
#   end

#   test "should get new" do
#     get new_post_url
#     assert_response :success
#   end

#   test "should create post" do
#     assert_difference("Post.count") do
#       post posts_url, params: { post: { content: @post.content } }
#     end

#     assert_redirected_to post_url(Post.last)
#   end

#   test "should show post" do
#     get post_url(@post)
#     assert_response :success
#   end

#   test "should get edit" do
#     get edit_post_url(@post)
#     assert_response :success
#   end

#   test "should update post" do
#     patch post_url(@post), params: { post: { content: @post.content } }
#     assert_redirected_to post_url(@post)
#   end

#   test "should destroy post" do
#     assert_difference("Post.count", -1) do
#       delete post_url(@post)
#     end

#     assert_redirected_to posts_url
#   end
# end
