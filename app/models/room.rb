# == Schema Information
#
# Table name: rooms
#
#  id                :bigint           not null, primary key
#  rmrecnbr          :string
#  room_number       :string
#  room_type         :string
#  floor_id          :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  last_time_checked :datetime
#
class Room < ApplicationRecord
  belongs_to :floor
  has_many :resources
  has_many :room_tickets
  has_many :specific_attributes
  has_many :room_states

  accepts_nested_attributes_for :specific_attributes

  def full_name
    [floor.building.nick_name, room_number].join(' ')
  end

  def room_state_for_today
    room_states.where(created_at: Time.zone.today.all_day).first
  end
end
