require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @photo = photos(:photo_one)
  end

  test "should show photo" do
    get :show, :id => @photo.to_param
    assert_response :success
  end

  test "should destroy photo" do
    # we sign in as the owner of the album
    sign_in users(:andrew)
    album = @photo.album
    assert_difference('Photo.count', -1) do
      delete :destroy, :id => @photo.to_param
    end

    assert_redirected_to album_path(album)
  end

  test "shouldn't destroy photo" do
    # not signed in
    album = @photo.album
    assert_no_difference('Photo.count') do
      delete :destroy, :id => @photo.to_param
    end

    assert_redirected_to new_user_session_path

    # we sign in as not the owner of the album
    sign_in users(:bill)
    album = @photo.album
    assert_no_difference('Photo.count') do
      delete :destroy, :id => @photo.to_param
    end

    assert_redirected_to album_path(album)
  end
end
