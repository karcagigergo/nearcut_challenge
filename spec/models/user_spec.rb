require 'rails_helper'

RSpec.describe User, type: :model do

  context 'User validation' do
    it 'ensures name presence' do
      user = User.new(password: '1234567890Aa').save
      expect(user).to eq(false)
    end

    it 'ensures password presence' do
      user = User.new(name: 'John Doe').save
      expect(user).to eq(false)
    end

    it 'is invalid if the password is not valid' do
      user = User.new(name: 'John Doe', password: 'aaaaaaaa')
      expect(user).to be_invalid  
    end

    it 'is valid if the password is valid' do
      user = User.new(name: 'John Doe', password: '1234567890Aa')
      expect(user).to be_valid  
    end

    it 'should save successfully' do
      user = User.new(name: 'John Doe', password: '1234567890Aa').save
      expect(user).to eq(true)  
    end
  end
end
