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
require 'authlogic'

class User < ActiveRecord::Base
  
  acts_as_authentic do |c|
      c.login_field = 'email'
  end
  
  include Gravtastic
  
  is_gravtastic :email, :rating => 'R', :secure => true, :default => 'identicon'
  
  validates_uniqueness_of :username
  validates_presence_of   :username
  validates_length_of     :username, :minimum => 3
  validates_length_of     :username, :maximum => 11
  
  has_and_belongs_to_many :shows
  has_many :comments
  
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  def to_param
    "#{id}-#{username}"
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
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end
    
private
  
end
