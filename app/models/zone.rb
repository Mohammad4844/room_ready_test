# == Schema Information
#
# Table name: zones
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Zone < ApplicationRecord
  validates :name, uniqueness: true
  has_many :buildings
end
