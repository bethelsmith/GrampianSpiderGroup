Factory.define :user do |user|
  user.name                  "Bee Smith"
  user.email                 "bethelsmith@hotmail.com"
  user.password              "mayf1eld"
  user.password_confirmation "mayf1eld"
end

Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :event do |event|
  event.date                    "01/04/2012"
  event.time                    "10:00"
  event.location_name           "Test Location"
  event.grid_ref                "NJ40"
end