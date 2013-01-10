class Tweet < ActiveRecord::Base
  attr_accessible :content
  default_scope order('created_at DESC')
  belongs_to :user
  has_many :favorites
  validates_associated :user
  validates :content, presence: true, length: { in: 1..140 }
end
