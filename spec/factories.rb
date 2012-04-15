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