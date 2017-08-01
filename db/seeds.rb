require 'ffaker'

# Create player data
20.times do |i|
  User.create!(
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name)
  print '.' if i % 1 == 0
end
puts "add players *20"
