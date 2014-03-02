require 'spec_helper'

describe ThingsController do
  let(:current_user) { FactoryGirl.create :user }

  describe "GET 'index'" do
    it "returns http success" do
      Thing.stub(:all).and_return 'an array of things'

      get 'index'

      response.should be_success
      expect(assigns[:things]).to eq 'an array of things'
    end
  end

  describe "GET 'show'" do
    before { controller.stub(:current_user).and_return(current_user) }

    context 'when Thing has NOT been rated by current_user' do
      let(:thing) { FactoryGirl.create :thing }

      it "finds a Thing and sets it to @thing and assigns a new opinion" do
        get 'show', id: thing.id
        response.should be_success
        expect(assigns[:thing]).to eq thing
        expect(assigns[:opinion]).to be_a Opinion
        expect(assigns[:opinion]).not_to be_persisted
      end
    end

    context 'when Thing HAS been rated by current_user' do
      let(:opinion) { FactoryGirl.create :opinion, user: current_user }

      it "finds a Thing and sets it to @thing and assigns a new opinion" do
        get 'show', id: opinion.thing.id
        response.should be_success
        expect(assigns[:thing]).to eq opinion.thing
        expect(assigns[:opinion]).to eq opinion
      end
    end
  end

end
