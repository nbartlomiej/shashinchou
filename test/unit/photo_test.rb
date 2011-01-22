require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess
  # Replace this with your real tests.

  test "should save simple photo" do
    assert Photo.new(:image => generate_test_image).save
  end

  test "should calculate photo properties" do
    p = Photo.new(:image => generate_test_image)
    p.save
    # properties that should be auto-updated
    # by paperclip whenever an image is supplied
    calculated = %w[image_file_name image_content_type image_file_size image_updated_at ]
    calculated.each do |key| 
      assert_not_nil eval("p.#{key}"),
      "#{key} should have been automatically calculated"
    end
  end

  test "cannot save photo without an image" do
    assert !Photo.new().save
  end

  # meta-test for the private method for generating 
  # test images (below); if this fails, other tests
  # may behave incorrectly (dependancies)
  test "private test image generator works" do
    assert_nothing_raised do
      assert_not_nil generate_test_image
      assert_not_equal generate_test_image, generate_test_image
    end
  end

  private

  # generates test image, uses a sample png shipped
  # with rails (copied to the fixture directory)
  # todo: broaden and probably simulate multiple extensions
  def generate_test_image
    fixture_file_upload("rails.png", "image/png")
  end
end
