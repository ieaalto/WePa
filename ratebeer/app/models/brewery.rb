class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :username, presence:true
  validates :year, numericality:{greater_than_or_equal_to: 1042}
  validate :no_later_than_current_year

  def no_later_than_current_year
    if year > Time.now.year
      errors.add(:year, "That's in the future!")
    end
  end


  include Average
end
