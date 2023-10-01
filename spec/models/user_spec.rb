# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    before do
      user = User.new(
        name: 'Test User',
        email: 'test@mail.com'
      )
      user.save
    end

    it 'should create a new user if all fields are filled out correctly' do
      expect(User.count).to eq(1)
    end
  end
end
