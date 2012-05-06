class Event < ActiveRecord::Base

  has_many    :reverse_registrations, :class_name => "Registration",
                                      :dependent => :destroy
  has_many    :attendees, :through => :reverse_registrations, :source => :user
  
  attr_accessible :date, :time, :location_name, :location_description, :grid_ref, :event_description
  
  grid_regex = /^((([S]|[N])[A-HJ-Z])|(([T]|[O])[ABFGLMQRVW])|([H][L-Z])|([J][LMQRVW]))([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?$/
  
  validate  :past
  validates :date,          :presence => true
  validates :time,          :presence => true
  validates :location_name, :presence => true,
                            :length   => { :maximum => 100 }
  validates :grid_ref,      :presence => true,
                            :length   => { :maximum => 14 },
                            :format   => { :with => grid_regex }
  
  def title
    "#{location_name} - #{date.strftime("%d %b %y")}"
  end
  
  def past?
    date < Date.today
  end
  
  def past
    errors.add("date", "is in the past") if date && past?
  end

end