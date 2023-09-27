require 'rails_helper'

RSpec.describe Dish, type: :model do
  subject { described_class.create(name: nil) }
  describe 'validations' do
    it 'should validate name' do
      expect(subject.errors[:name].size).to eq(1)
    end
  end
end
