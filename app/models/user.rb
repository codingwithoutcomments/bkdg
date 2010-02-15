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
  
  acts_as_authentic
  
  include Gravtastic
  
  is_gravtastic :email, :rating => 'R', :secure => true, :default => 'identicon'
  
  has_and_belongs_to_many :shows
  has_many :comments
  
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
  
end
