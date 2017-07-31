class Match < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :games, dependent: :destroy  
end
