# == Schema Information
# Schema version: 20091207050051
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  hashed_password :string(255)
#  salt            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  username        :string(255)
#  admin           :boolean
#  points          :integer         default(0)
#

require 'digest/sha1'

class User < ActiveRecord::Base
  
  include Gravtastic
  
  is_gravtastic :name, :rating => 'R', :secure => true, :default => 'identicon'
  
  has_and_belongs_to_many :shows
  has_many :comments
  
  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_uniqueness_of :username
  
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  validate :password_non_blank
  validates_format_of :name, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  def password
    @password
  end

  def password=(pwd)
       @password = pwd
       return if pwd.blank?
       create_new_salt
       self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  def attending_show(show)
    shows << show
  end
  
  def add_comment_to_user(comment_to_add)
    comments << comment_to_add
  end
  
  def remove_comment_from_user(comment_to_remove)
    comments.delete(comment_to_remove)
  end
    
private

  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
end
