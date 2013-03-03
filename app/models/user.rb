class User < ActiveRecord::Base
  include SimplestAuth::Model

  attr_accessible :email, :password, :password_confirmation
  attr_accessor   :password

  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A([a-z]|\d)+@email.wm.edu\z/ }
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true

  authenticate_by :email
end
