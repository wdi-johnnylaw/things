require 'spec_helper'

describe ThingsController do
  let(:current_user) { FactoryGirl.create :user }

  describe "GET 'index'" do
    context 'when format is HTML' do
      it do
        Thing.should_not_receive(:find)
        get 'index'
        response.should be_success
      end
    end
  end

  describe "GET 'show'" do
    before { controller.stub(:current_user).and_return(current_user) }
    let(:db_thing) { FactoryGirl.create :thing }

    context 'when format is HTML' do
      it do
        Thing.should_not_receive(:find)
        get 'show', id: 234
        response.should be_success
      end
    end
  end
end
