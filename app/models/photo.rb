class Photo < ActiveRecord::Base
  belongs_to :product
  has_attached_file :image

  validates_attachment_presence :image
end
