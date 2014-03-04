require 'spec_helper'

describe ThingsController do
  let(:current_user) { FactoryGirl.create :user }

  describe "GET 'index'" do
    context 'when format is HTML' do
      it "assigns all things to @things" do
        Thing.stub(:all).and_return 'an array of things'

        get 'index'

        response.should be_success
        expect(assigns[:things]).to eq 'an array of things'
      end
    end

    context 'when format is JSON' do
      render_views

      it 'gives back all things without the created_at and updated_at' do
        opinion = FactoryGirl.create :opinion, user: current_user
        database_thing = opinion.thing

        get 'index', format: 'json'

        things = JSON.parse(response.body)['things']
        expect(things.count).to eq 1

        thing = things.first
        expect(thing['id']).to eq database_thing.id
        expect(thing['name']).to eq database_thing.name
        expect(thing['image_url']).to eq "http://#{request.host}#{controller.class.helpers.asset_url(database_thing.image_url)}"
        expect(thing['url']).to eq controller.thing_url(database_thing, format: 'json')
        expect(thing['opinions']['count']).to eq 1
        expect(thing.keys.count).to eq 5  # id, name, image_url, url, opinions
      end
    end
  end

  describe "GET 'show'" do
    before { controller.stub(:current_user).and_return(current_user) }
    let(:db_thing) { FactoryGirl.create :thing }

    context 'when format is HTML' do
      it "finds a Thing and sets it to @thing" do
        get 'show', id: db_thing.id
        response.should be_success
        expect(assigns[:thing]).to eq db_thing
      end
    end

    context 'when format is JSON' do
      render_views

      context 'when current_user has registered an opinion' do
        it 'renders the correct information' do
          db_opinion = FactoryGirl.create :opinion, user: current_user, thing: db_thing
          Thing.any_instance.stub(:average_rating).and_return 2.334
          get 'show', id: db_thing.id, format: 'json'

          thing = JSON.parse(response.body)['thing']
          expect(thing['id']).to eq db_thing.id
          expect(thing['name']).to eq db_thing.name
          expect(thing['description']).to eq db_thing.description
          expect(thing['image_url']).to eq "http://#{request.host}#{controller.class.helpers.asset_url(db_thing.image_url)}"
          expect(thing['average_rating']).to eq 2.334
          opinions = thing['opinions']
          expect(opinions.count).to eq 1

          expect(thing['current_user_opinion']['url']).to eq opinion_url(db_opinion, format: 'json')
          expect(thing['current_user_opinion']['thing']['id']).to eq db_opinion.thing_id
          expect(thing['current_user_opinion']['rating']).to eq db_opinion.rating
          expect(thing['current_user_opinion']['comment']).to eq db_opinion.comment
          expect(thing['current_user_opinion']['is_new']).to eq false

          opinion = opinions.first
          expect(opinion['rating']).to eq db_opinion.rating
          expect(opinion['comment']).to eq db_opinion.comment
          expect(Time.parse(opinion['created_at']).to_s).to eq Time.parse(db_opinion.created_at.to_s).to_s
          expect(opinion['username']).to eq current_user.username
          expect(opinion.keys.count).to eq 5
        end
      end

      context 'when current_user has NOT registered an Opinion' do
        it 'renders a blank user_opinion' do
          get 'show', id: db_thing.id, format: 'json'

          thing = JSON.parse(response.body)['thing']

          expect(thing['current_user_opinion']['url']).to eq opinions_url(format: 'json')
          expect(thing['current_user_opinion']['thing']['id']).to eq db_thing.id
          expect(thing['current_user_opinion']['rating']).to be_nil
          expect(thing['current_user_opinion']['comment']).to be_nil
          expect(thing['current_user_opinion']['is_new']).to eq true
        end
      end
    end
  end
end
