class RatingsController < ApplicationController
  def index
    #Eventual consistency;
    unless fragment_exist?('ratings')
      @recent_ratings = Rating.recent 5
      @best_beers = Beer.top 3
      @best_breweries = Brewery.top 3
      @top_raters = User.top_raters 3
      @best_styles = Style.top 3
    end
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    if @rating.save
      session[:last_rating] = "#{@rating.beer.name} #{@rating.score} points"
      current_user.ratings << @rating
      redirect_to ratings_path
    else
      @beers = Beer.all
      render :new
    end

  end

  def destroy
    rating = Rating.find(params[:id])
    if rating.user == current_user
      rating.delete
      redirect_to :back
    else
      redirect_to :root, notice: "Not logged in!"
    end
  end

end