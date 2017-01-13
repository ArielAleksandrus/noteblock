FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "email_do_fulano#{rand(100000)}#{n}@email.com"}
    password "123456"
    password_confirmation "123456"
  end
end
