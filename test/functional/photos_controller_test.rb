require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  setup do
    @photo = photos(:one)
  end

  test "should create photo" do
    assert_difference('Photo.count') do
      post :create, :photo => @photo.attributes
    end

    assert_redirected_to photo_path(assigns(:photo))
  end

  test "should show photo" do
    get :show, :id => @photo.to_param
    assert_response :success
  end

  test "should destroy photo" do
    assert_difference('Photo.count', -1) do
      delete :destroy, :id => @photo.to_param
    end

    assert_redirected_to photos_path
  end
end
