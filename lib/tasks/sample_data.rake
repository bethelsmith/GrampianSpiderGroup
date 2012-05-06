require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_events
    make_registrations
    make_records
  end
end

def make_users
  admin = User.create!(:name => "Example User",
                 :email => "example@grampianspidergroup.com",
                 :password => "grampianspidergroup",
                 :password_confirmation => "grampianspidergroup")
  admin.toggle!(:admin)
  99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@grampianspidergroup.com"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
  end
end

def make_events
  99.times do |n|
      startdate = Date.today
      date = startdate += 1.day
      time = "10:00"
      location_name  = "Test location - #{n+1}"
      grid_ref = "NJ40"
      Event.create!(:date => date,
                   :time  => time,
                   :location_name => location_name,
                   :grid_ref => grid_ref)
  end
end

def make_registrations

  users = User.all
  events = Event.all
  
  attendees = users[0..20]
  event1 = events[0]
  event2 = events[1]
  event3 = events[2]
  
  attendees.each {|attendee| attendee.attend!(event1)}
  attendees.each {|attendee| attendee.attend!(event2)}
  attendees.each {|attendee| attendee.attend!(event3)}
end

def make_records
  10.times do
    User.all(:limit => 5).each do |user|
      user.records.create!(:date => Date.today,
          :species => "Arianella cucurbitina",
          :location => "Aberdeenshire",
          :grid_ref => "NJ40")
    end
  end
end