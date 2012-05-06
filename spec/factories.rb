FactoryGirl.define do
  factory :user do
    sequence(:name)       { |n| "Person #{n}" }
    sequence(:email)      { |n| "person_#{n}@grampianspidergroup.com"} 
    password              "grampianspidergroup"
    password_confirmation "grampianspidergroup"
  end
end

FactoryGirl.define do
  factory :event do
    date                        Date.today
    time                        "10:00"
    sequence(:location_name)   { |n| "Test Location #{n}"}
    grid_ref                    "NJ40"
  end
  
FactoryGirl.define do
  factory :record do
    association     :user
    date            Date.today
    species         "Arianella cucurbitina"
    location        "Aberdeenshire"
    grid_ref        "NJ40"
  end
end
  
end
