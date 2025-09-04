require "rails_helper"

RSpec.describe 'Post', type: :request do           #
  it 'index' do 
    get posts_url
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json["posts"]).to be_an(Array)
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
