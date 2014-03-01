require 'spec_helper'

describe User do
  describe 'validations' do
    let(:user) { FactoryGirl.build :user }
    subject { user }

    context 'when all attributes are valid' do
      it { should be_valid }
    end

    context 'when username duplicates one in database' do
      before { FactoryGirl.create :user, username: user.username }

      it do
        should_not be_valid
        expect(subject.errors[:username]).to include "has already been taken"
      end
    end
  end
end
