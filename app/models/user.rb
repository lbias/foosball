class User < ApplicationRecord
  validates_presence_of :last_name, :first_name

  has_many :team_users
  has_many :teams, through: :team_users  

  def name
    [first_name, last_name].join(' ')
  end
end
