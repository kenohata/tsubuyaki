class Tweet < ActiveRecord::Base
  attr_accessible :content, :image
  default_scope order('created_at DESC').includes(:favorites, :user)
  belongs_to :user
  has_many :favorites
  mount_uploader :image, ImageUploader
  validates_associated :user
  validates :content, presence: true, length: { in: 1..140 }

  def favorited? user
    favorites.any? do |f|
      f.user == user
    end
  end
end
