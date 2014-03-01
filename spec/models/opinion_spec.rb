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
  end
end
