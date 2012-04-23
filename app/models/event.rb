class Event < ActiveRecord::Base
  
  attr_accessible :date, :time, :location_name, :grid_ref
  
  grid_regex = /^((([S]|[N])[A-HJ-Z])|(([T]|[O])[ABFGLMQRVW])|([H][L-Z])|([J][LMQRVW]))([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?$/
  
  validates :date,          :presence => true
  validates :time,          :presence => true
  validates :location_name, :presence => true,
                            :length   => { :maximum => 100 }
  validates :grid_ref,      :presence => true,
                            :length   => { :maximum => 14 },
                            :format   => { :with => grid_regex }
  
  def title
    "#{location_name} - #{date}"
  end

end