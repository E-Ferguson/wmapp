class Worker < ActiveRecord::Base
  include SimplestAuth::Model

  attr_accessible :email, :password, :password_confirmation, :phone, :name
  attr_accessor   :password

  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A([a-z]|\d)+@wm.edu\z/, :message => "You must have a valid William & Mary staff email address to register." }
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true

  authenticate_by :email
end
