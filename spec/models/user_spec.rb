# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    before do
      user = User.new(
        name: 'Test User',
        email: 'test@mail.com',
        password: "123456"
      )
      user.save
    end

    it 'should create a new user if all fields are filled out correctly' do
      expect(User.count).to eq(1)
    end
  end
end
