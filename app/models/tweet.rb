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

  def has_image?
    !image_url.to_s.empty?
  end

  def as_json options = {}
    {
      id: id,
      user_id: user_id,
      content: content,
      has_image: has_image?,
      image: {
        url: image_url.to_s
      },
      user: {
        name: user.name,
        avatar: user.avatar_url.to_s
      },
      favorite_counts: favorites.size,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
