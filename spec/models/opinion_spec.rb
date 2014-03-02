require 'spec_helper'

describe Opinion do
  let(:opinion) { FactoryGirl.build :opinion }
  subject { opinion }

  describe 'validations' do
    context 'valid attributes' do
      it { should be_valid }
    end

    context 'when (user_id, thing_id) are duplicates' do
      before { FactoryGirl.create :opinion, user_id: opinion.user.id, thing_id: opinion.thing.id }
      it { should_not be_valid }
    end

    context 'when comment is shorter than 15 characters' do
      let(:opinion) { FactoryGirl.build :opinion, comment: '12345678901234' }

      it do
        should_not be_valid
        expect(opinion.errors[:comment]).to include "must be at least 15 characters"
      end
    end

    describe '.rating' do
      subject { opinion.errors[:rating] }
      let(:opinion) do
        FactoryGirl.build(:opinion, rating: rating).tap do |opinion|
          opinion.valid?
        end
      end

      context 'when rating is not present' do
        let(:rating) { nil }
        it { should include "must be an integer between 1 and 5" }
      end

      context 'when rating is present but is greater than 5' do
        let(:rating) { 6 }
        it { should include "must be an integer between 1 and 5" }
      end

      context 'when rating is present but is less than 1' do
        let(:rating) { 0 }
        it { should include "must be an integer between 1 and 5" }
      end

      context 'when rating is non-integer' do
        let(:rating) { 3.2 }
        it { should include "must be an integer between 1 and 5" }
      end
    end
  end
end
