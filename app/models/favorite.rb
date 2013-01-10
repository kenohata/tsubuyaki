class Favorite < ActiveRecord::Base
  attr_accessible :tweet
  belongs_to :user
  belongs_to :tweet
end
