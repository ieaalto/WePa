class Membership < ActiveRecord::Base
  belongs_to :beer_club
  belongs_to :user

  validates :user, uniqueness: {scope: :beer_club, message: "is already a member!"}

  def self.is_member(user,club)
    membership = Membership.find_by(user_id:user.id,beer_club_id:club.id)
  end
end
