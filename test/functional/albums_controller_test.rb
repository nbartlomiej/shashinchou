require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @album = albums(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:albums)
  end

  test "should get new" do
    sign_in users(:bill)
    get :new
    assert_response :success
  end

  test "shouldn't get new when unauthorised" do
    # sign_in users(:bill) - commented out, unauthorised
    get :new
    assert_response 302 # redirect
  end

  test "should create album" do
    sign_in users(:bill)
    assert_difference('Album.count') do
      post :create, :album => Album.new(
        :name => 'Barcelona 2012'
      )
    end
    assert_redirected_to album_path(assigns(:album))
  end

  test "shouldn't create album when user unauthorised" do
    user = users(:bill)
    # commented out - that's what we're testing
    # sign_in user
    assert_no_difference('Album.count') do
      post :create, :album => Album.new(
        :name => 'Barcelona 2012',
        :user => user
      )
    end
  end

  test "should show album" do
    get :show, :id => @album.to_param
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:andrew)
    get :edit, :id => @album.to_param
    assert_response :success
  end

  test "should update album" do
    sign_in users(:andrew)
    put :update, :id => @album.to_param, :album => @album.attributes
    assert_redirected_to album_path(assigns(:album))
  end

  test "shouldn't update album when unauthorised" do
    # not logged in
    put :update, :id => @album.to_param, :album => @album.attributes
    assert_redirected_to new_user_session_path

    # not the album's owner
    sign_in users(:andrew)
    put :update, :id => @album.to_param, :album => @album.attributes
    assert_redirected_to album_path(assigns(:album))
  end
  test "should destroy album" do
    sign_in users(:andrew)
    assert_difference('Album.count', -1) do
      delete :destroy, :id => @album.to_param
    end

    assert_redirected_to albums_path
  end

  test "shouldn't destroy album when not authorised" do
    # not signed in
    assert_no_difference('Album.count') do
      delete :destroy, :id => @album.to_param
    end
    assert_redirected_to new_user_session_path

    # signed in as different user (not the album's creator)
    sign_in users(:bill)
    assert_no_difference('Album.count') do
      delete :destroy, :id => @album.to_param
    end
  end
end
