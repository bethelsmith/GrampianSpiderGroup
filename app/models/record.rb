class Record < ActiveRecord::Base
  attr_accessible  :date, :species, :location, :grid_ref, :comments
  
  belongs_to :user
  default_scope :order => 'records.created_at DESC'
  
  grid_regex = /^((([S]|[N])[A-HJ-Z])|(([T]|[O])[ABFGLMQRVW])|([H][L-Z])|([J][LMQRVW]))([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?$/
  
  validate  :future
  validates :user_id,   :presence => true
  validates :date,      :presence => true
  validates :location,  :presence => true,
                        :length   => { :maximum => 100 }
  validates :grid_ref,  :presence => true,
                        :length   => { :maximum => 100 },
                        :format   => { :with => grid_regex }

  searchable do
    text :recorder, :species, :date_string, :location
  end
  
  def recorder
    user.name
  end
  
  def date_string
    date.strftime("%d %b %y")
  end
 
  def title
    "#{user.name} - #{species} - #{date.strftime("%d %b %y")} - #{location} - #{grid_ref}"
  end
  
  def future?
    date > Date.today
  end
  
  def future
    errors.add("date", "is in the future") if date && future?
  end

end
