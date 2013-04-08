class Buildings < ActiveRecord::Base
  #attr_accessible :name, as: :admin
  
  attr_accessible :name
  
  #accepts_nested_attributes_for :name

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
end
