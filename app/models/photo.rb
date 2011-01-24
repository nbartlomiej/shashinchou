class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => {:large => '1024x768>', :thumbnail => '256x256#'}, :default_style => :large

  validates_attachment_presence :image

  belongs_to :album
  has_many :comments
end
