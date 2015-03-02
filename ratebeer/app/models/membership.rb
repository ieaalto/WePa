class Membership < ActiveRecord::Base
  belongs_to :beer_club
  belongs_to :user

  validates :user, uniqueness: {scope: :beer_club, message: "is already a member!"}

  scope :confirmed, -> (club){where confirmed:true, beer_club: club}
  scope :unconfirmed, -> (club){where confirmed:false || nil, beer_club: club}

  def self.is_member(user,club)
    membership = Membership.find_by(user_id:user.id,beer_club_id:club.id)
  end

  def self.is_confirmed?(user, club)
    not Membership.find_by(user_id:user.id, beer_club_id:club.id,confirmed:true).nil?
  end

end
