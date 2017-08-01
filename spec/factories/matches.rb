FactoryGirl.define do
  factory :match do
    transient do
      users { [create(:user), create(:user)] }
    end

    before :create do |match, evaluator|
      match.add(evaluator.users.in_groups(2))
    end

    trait :ended do
      after :create do |match|
        create(:game, match: match) until match.reload.ended?
      end
    end    
  end
end
