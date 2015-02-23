class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  belongs_to :style

  validates :name, presence:true

  include Average

  def to_s
    return name+", "+brewery.name
  end

  def self.top(n)
    best_rated = Beer.all.sort_by{ |b| -(b.average_rating||0) }
    best_rated[0,n]
  end

end
