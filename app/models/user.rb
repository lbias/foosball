class User < ApplicationRecord
  validates_presence_of :last_name, :first_name

  def name
    [first_name, last_name].join(' ')
  end  
end
