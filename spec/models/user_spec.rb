# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # You can modify devise functionality so it is important to keep track of the modal still working as you intend if
  # you ever do change the devise config, and we will at some point
  context 'with incorrect password' do
    let(:user) { build :user, email: 'correct@mail.com', password: '11%^' }
    it 'will not be created' do
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Password is too short (minimum is 6 characters)')
      expect(User.all.size).to eq 0
    end
  end
end
