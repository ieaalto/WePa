class User < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_secure_password

  validates :username, uniqueness: true,
                       length: {minimum: 3, maximum: 15}

  validates :password, length: {in: 3..15}
  validates :password, format: {with: /\d.[A-Z]|[A-Z].*\d/, message: "Password has to contain a number and a upper case letter." }
  include Average

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by(&:score).last.beer
  end

  def favorite_style
    styles = ratings.map{ |r| r.beer.style}
    best = nil
    return nil if styles.nil?
    styles.each do |s|
      if style_average(s) > style_average(best)
             best = s
      end
    end
    return best
  end

  def favorite_brewery
    breweries = beers.map{|b| b.brewery}
    best = nil
    return nil if breweries.nil?
    breweries.each do |b|
      if best.nil?
        best = b;
      else if brewery_average(b.id) > brewery_average(best.id)
            best = b
           end
      end
    end
    return best
  end

  def style_average(style)
    style_ratings = ratings.select{|r| r.beer.style == style}
    style_scores = style_ratings.map{|r| r.score}
    return 0 if style_ratings.count == 0
    return style_scores.sum / style_ratings.count
  end

  def brewery_average(brewery)
    brewery_ratings = ratings.select{|r| r.beer.brewery_id == brewery}
    brewery_scores = brewery_ratings.map{|r| r.score}
    return 0 if brewery_ratings.count == 0
    return brewery_scores.sum / brewery_ratings.count
  end

  def self.top_raters(n)
    by_no_of_raters = User.all.sort_by{|b| -b.ratings.count}
    by_no_of_raters[0,n]
  end

end
