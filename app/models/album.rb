class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos

  accepts_nested_attributes_for :photos, :allow_destroy => true

  validates :user_id, :presence => true
end
