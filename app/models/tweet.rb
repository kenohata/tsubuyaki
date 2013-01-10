class Tweet < ActiveRecord::Base
  attr_accessible :content
  default_scope order('created_at DESC')
  belongs_to :user
end
