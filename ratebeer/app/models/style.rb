class Style < ActiveRecord::Base
  has_many :beers
  has_many :ratings, through: :beers

  include Average

  def to_s
    name
  end

  def self.top(n)
    by_rating = Style.all.sort_by{ |b| -(b.average_rating||0) }
    by_rating[0,n]
  end

end
