class Api::TweetsController < TweetsController
  def create
    @tweet = current_user.tweets.build(params[:tweet])

    if @tweet.save
      render json: @tweet, status: :created, location: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end
end