require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess
  # Replace this with your real tests.

  test "should save simple photo" do
    assert Photo.new(:image => fixture_png_upload).save
  end

  test "should calculate photo properties" do
    p = Photo.new(:image => fixture_png_upload)
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

  test "images greater than 1024 are scaled" do
    image_path = "images/big.png"
    # checking locally whether the image file
    # is indeed above 1024 - so that scaling is
    # really tested; a hack, works only on pngs
    # see: http://stackoverflow.com/questions/2450906/is-there-a-simple-way-to-get-image-dimensions-in-ruby
    dimensions = IO.read("#{Rails.root}/test/fixtures/#{image_path}")[0x10..0x18].unpack('NN') # [width, height]
    assert dimensions[0] > 1024
    assert dimensions[1] > 768

    photo = Photo.new(:image => fixture_png_upload(image_path))
    photo.save
    # fetching the image in its default style
    geometry = Paperclip::Geometry.from_file(photo.image.path)

    # has the image been properly scaled?
    assert geometry.width <= 1024
    assert geometry.height <= 768
  end

  # meta-test for the private method for generating 
  # test images (below); if this fails, other tests
  # may behave incorrectly (dependancies)
  test "private test image generator works" do
    assert_nothing_raised do
      assert_not_nil fixture_png_upload
      assert_not_nil fixture_png_upload 'images/big.png'
      assert_not_equal fixture_png_upload, fixture_png_upload
    end
  end

  private

  # generates test image, uses a sample png shipped
  # with rails (copied to the fixture directory) or 
  # any other png file with custom path
  def fixture_png_upload path="rails.png"
    # creates a mock uploaded file (for testing file upload...),
    # will search for files in the ./test/fixtures directory
    fixture_file_upload(path, "image/png")
  end
end
