class Favorite < ActiveRecord::Base
  attr_accessible :tweet_id, :user_id
  belongs_to :user
  belongs_to :tweet
end
