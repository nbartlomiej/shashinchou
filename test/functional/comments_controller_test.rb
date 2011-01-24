require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @comment = comments(:one)
  end

  test "should create comment" do
    sign_in users(:andrew)
    assert_difference('Comment.count') do
      post :create, :comment => @comment.attributes
    end
  end

  test "should destroy comment" do
    sign_in users(:andrew)
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => @comment.to_param
    end
  end

  test "shouldn't destroy comment when user unauthorised" do
    # not logged in
    assert_difference('Comment.count') do
      delete :destroy, :id => @comment.to_param
    end

    assert_redirected_to new_user_session_path

    # invalid user (not the author of comment)
    sign_in users(:bill)
    assert_no_difference('Comment.count') do
      delete :destroy, :id => @comment.to_param
    end

    assert_redirected_to comments_path
  end
end
