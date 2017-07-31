class Team < ApplicationRecord
  has_many :team_users
  has_many :players, through: :team_users, class_name: 'User', source: :user  
end
