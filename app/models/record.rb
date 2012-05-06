class Record < ActiveRecord::Base
  attr_accessible  :date, :species, :location, :grid_ref, :comments
  
  belongs_to :user
  default_scope :order => 'records.created_at DESC'
  
  grid_regex = /^((([S]|[N])[A-HJ-Z])|(([T]|[O])[ABFGLMQRVW])|([H][L-Z])|([J][LMQRVW]))([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?$/
  
  validates :user_id,   :presence => true
  validates :date,      :presence => true
  validates :location,  :presence => true,
                        :length   => { :maximum => 100 }
  validates :grid_ref,  :presence => true,
                        :length   => { :maximum => 100 },
                        :format   => { :with => grid_regex }


 
  def title
    "#{user.name} - #{species} - #{date.strftime("%d %b %y")} - #{location} - #{grid_ref}"
  end

end
