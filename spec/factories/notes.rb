FactoryGirl.define do
  factory :note do
  	title "Some random title eh"
    sequence(:content){|n| ('a'..'z').to_a.shuffle[0,80].join}
    privacy Note.privacy.values.sample
    sequence(:visualizations){|n| rand(n + 20)}
    first_visualization Time.now
    status Note.status.values.sample
    user
  end
end
