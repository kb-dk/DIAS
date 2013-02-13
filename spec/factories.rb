FactoryGirl.define do
  factory :admin, class: User do
    sequence(:pid) { |n| "DO_NOT_USE#{n}" }
    name "Tester Testesen"
    email "test@kb.dk"
    password "test123"

    after(:create) do |user|
      user.stub("admin?").and_return("true")
      user.stub(update_attributes: false)
    end
  end
end
