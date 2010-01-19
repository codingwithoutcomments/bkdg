# == Schema Information
# Schema version: 20091207050051
#
# Table name: bandpictures
#
#  id          :integer         not null, primary key
#  original    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  band_id     :integer
#  large       :string(255)
#  largesquare :string(255)
#  medium      :string(255)
#  small       :string(255)
#

class Bandpicture < ActiveRecord::Base
  belongs_to :bands
end
