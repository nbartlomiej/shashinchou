class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo

  validates :content, :presence => true, :length => {:within => 3..512}
end
