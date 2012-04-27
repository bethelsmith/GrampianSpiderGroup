require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_events
    make_registrations
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
  event = events.first
  
  attendees = users[0..20]
  
  attendees.each {|attendee| attendee.attend!(event)}
  
end

  
  
  