module TweetsHelper
  def favorite_button tweet, user, fav_text, unfav_text
    if tweet.favorited? user
      text = unfav_text
      method = :delete
    else
      text = fav_text
      method = :post
    end
    link_to text, tweet_favorite_path(tweet), method: method, class: "btn"
  end
end
