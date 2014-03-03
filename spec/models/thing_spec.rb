require 'spec_helper'

describe Thing do
  let(:thing) { FactoryGirl.build :thing }
  subject { thing }

  describe '#average_rating' do
    before do
      FactoryGirl.create :opinion, thing: thing, rating: 1
      FactoryGirl.create :opinion, thing: thing, rating: 2
    end

    its(:average_rating) { should eq 1.5 }
  end

  describe 'validations' do
    context 'when all attributes are valid' do
      it { should be_valid }
    end

    context 'when name duplicates name of another thing in database' do
      before { FactoryGirl.create :thing, name: thing.name }

      it do
        should_not be_valid
        expect(thing.errors[:name]).to include "has already been taken"
      end
    end
  end

  describe 'associations' do
    it { should respond_to :opinions }
  end
end

# WDI: Notice we use FactoryGirl.build instead of FactoryGirl.create whenever possible
#   This builds us up a record (like calling Thing.new with the @valid_attributes) but
#   does NOT save it to the database, making for faster-running specs
#
#   Also notice that it is not necessary for the "it" block to have a string, as in
#     it 'should do something' do
#       expect...
#     end
#   As with all blocks then, we can express the block itself inside of {} instead of do-end
#   This is only a good idea for one-liners, which - as you can see - many of our specs are.
