class Api::TweetsController < TweetsController
  skip_before_filter :verify_authenticity_token

  def index
    @tweets = Tweet.all

    render json: @tweets
  end

  def show
    @tweet = Tweet.find(params[:id])

    render json: @tweet
  end

  def create
    @tweet = current_user.tweets.build(params[:tweet])

    if @tweet.save
      render json: @tweet, status: :created, location: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def update
    @tweet = current_user.tweets.find(params[:id])

    if @tweet.update_attributes(params[:tweet])
      render json: @tweet
    else
      render json: { message: 'Validation Error.' }
    end
  end

  def favorite
    @tweet = Tweet.find(params[:id])
    @favorite = current_user.favorites.build tweet: @tweet

    if @favorite.save
      render json: { message: 'You favorited successfully.' }
    else
      render json: { message: 'Failed' }
    end
  end

  def unfavorite
    @favorite = current_user.favorites.find_by_tweet_id(params[:id])
    @favorite.destroy

    render json: { message: 'favorite deleted.' }
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])
    @tweet.destroy

    render json: { message: 'deleted.' }
  end
end