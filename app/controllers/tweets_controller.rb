class TweetsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_tweet, only:[:edit, :update, :destroy]

  def index
    @tweets = Current.user.tweets
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Current.user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path, notice: "Tweet was scheduled Successfully"
    else
      render :new, status: 422
    end
  end

  def edit
  end

  def show
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: "Tweet was updated Successfully"
    else
      render :edit, status: 422
    end

  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "Tweet was unscheduled" 
  end

  private

  def tweet_params
    params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
  end

  def set_tweet
    @tweet =  Current.user.tweets.find(params[:id])
  end

end
