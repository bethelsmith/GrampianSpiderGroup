class Event < ActiveRecord::Base
  validates :date, :time, :grid_ref, :presence => true
end
