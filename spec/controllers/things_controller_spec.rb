require 'spec_helper'

describe ThingsController do

  describe "GET 'index'" do
    it "returns http success" do
      Thing.stub(:all).and_return 'an array of things'

      get 'index'

      response.should be_success
      expect(assigns[:things]).to eq 'an array of things'
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      Thing.stub(:find).with('589').and_return 'one silly thing'
      get 'show', id: 589
      response.should be_success
      expect(assigns[:thing]).to eq 'one silly thing'
    end
  end

end
