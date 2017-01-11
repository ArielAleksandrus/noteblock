FactoryGirl.define do
  factory :user do
		sequence(:email){|n| "email#{rand(10000)}#{n}@email.com"} 
		sequence(:username){|n| "fulano#{rand(10000)}#{n}"}  
		password "123456"
		password_confirmation "123456"  
  end
end
