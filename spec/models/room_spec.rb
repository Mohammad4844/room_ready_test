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
require 'rails_helper'

RSpec.describe Room, type: :model do
  
  context "the Factory" do
    it 'is valid' do
      expect(build(:room)).to be_valid
    end
  end

end
