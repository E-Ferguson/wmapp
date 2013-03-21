# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :worker do
    email "bob@wm.edu"
    password "foobar"
    password_confirmation "foobar"
  end
end
