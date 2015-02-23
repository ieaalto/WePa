class Brewery < ActiveRecord::Base

  include Average

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence:true
  validates :year, numericality:{greater_than_or_equal_to: 1042}
  validate :no_later_than_current_year

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  def no_later_than_current_year
    if year > Time.now.year
      errors.add(:year, "That's in the future!")
    end
  end

  def self.top(n)
    by_rating = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
    by_rating[0,n]
  end

end
