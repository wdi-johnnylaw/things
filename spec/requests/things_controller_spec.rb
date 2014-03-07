require 'spec_helper'

describe ThingsController do
  let(:current_user) { FactoryGirl.create :user }
  before { ApplicationController.any_instance.stub(:current_user).and_return(current_user) }

  describe "GET '/things.json'" do
    context 'when there is one Thing and it has one Opinion' do
      let!(:opinion) { FactoryGirl.create :opinion, user: current_user }

      it 'gives back all things without the created_at and updated_at' do
        get '/things.json'

        json = JSON.parse response.body
        expect(json['things']).to eq([{
          'id' => opinion.thing.id,
          'name' => opinion.thing.name,
          'image_url' => "http://#{request.host}#{controller.class.helpers.asset_url(opinion.thing.image_url)}",
          'url' => controller.thing_url(opinion.thing, format: 'json'),
          'opinions' => {
            'count' => 1
          }
        }])
        expect(json.keys).to eq ['things', 'messages', 'form_authenticity_token']
      end
    end
  end

  describe "GET '/things/:id.json'" do
    let(:thing) { FactoryGirl.create :thing }

    context 'when current_user has registered an opinion about the thing' do
      let!(:opinion) { FactoryGirl.create :opinion, thing: thing, user: current_user }

      it 'gives back lots of stuff' do
        Thing.any_instance.stub(:average_rating).and_return 2.334
        get "/things/#{thing.id}.json"

        expect(response).to be_success
        json = JSON.parse response.body
        expect(json.keys).to eq ['thing', 'messages', 'form_authenticity_token']

        expect(json['thing'].keys).to eq ['id', 'name', 'description', 'average_rating', 'image_url', 'opinions', 'current_user_opinion']

        expect(json['thing']).to include ({
          'id' => thing.id,
          'name' => thing.name,
          'description' => thing.description,
          'average_rating' => 2.334,
          'image_url' => "http://#{request.host}#{controller.class.helpers.asset_url(thing.image_url)}",
        })

        expect(json['thing']['opinions']).to eq([{
          'id' => opinion.id,
          'rating' => opinion.rating,
          'comment' => opinion.comment,
          'created_at' => JSON.parse(opinion.to_json(only: :created_at))['created_at'],
          'username' => current_user.username
        }])

        expect(json['thing']['current_user_opinion']).to eq({
          'id' => opinion.id,
          'rating' => opinion.rating,
          'comment' => opinion.comment,
          'created_at' => JSON.parse(opinion.to_json(only: :created_at))['created_at'],
          'username' => current_user.username,
          'url' => opinion_url(opinion, format: 'json'),
          'is_new' => false,
          'thing' => {
            'id' => thing.id,
            'average_rating' => 2.334
          }
        })
      end
    end

    context 'when current_user has NOT registered an opinion' do
      it 'has an empty current_user_opinion' do
        Thing.any_instance.stub(:average_rating).and_return 2.334
        get "/things/#{thing.id}.json"

        expect(response).to be_success
        json = JSON.parse response.body
        expect(json.keys).to eq ['thing', 'messages', 'form_authenticity_token']
        expect(json['thing'].keys).to eq ['id', 'name', 'description', 'average_rating', 'image_url', 'opinions', 'current_user_opinion']
        expect(json['thing']['current_user_opinion']).to eq({
          'id' => nil,
          'username' => current_user.username,
          'rating' => nil,
          'comment' => nil,
          'is_new' => true,
          'url' => opinions_url(format: 'json'),
          'created_at' => nil,
          'thing' => {
            'id' => thing.id,
            'average_rating' => 2.334
          }
        })
      end
    end
  end
end
