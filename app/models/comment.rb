# == Schema Information
# Schema version: 20091207050051
#
# Table name: comments
#
#  id           :integer         not null, primary key
#  user_comment :text
#  created_at   :datetime
#  updated_at   :datetime
#  show_id      :integer
#  user_id      :integer
#

class Comment< ActiveRecord::Base
  belongs_to :shows
  belongs_to :user
  
  def new_instance_of_comment
    return Comment.new
  end
  
end
