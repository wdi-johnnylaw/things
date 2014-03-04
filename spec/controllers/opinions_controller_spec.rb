require 'spec_helper'

describe OpinionsController do
  let(:current_user) { FactoryGirl.create :user }
  let(:thing) { FactoryGirl.create :thing }
  let(:validity) { false }
  let(:post_params) do
    { opinion: { thing_id: thing.id, rating: 5, comment: 'Awesome' } }
  end

  before do
    controller.stub(:current_user).and_return current_user
  end

  describe "POST 'create'" do
    let(:opinion) { assigns(:opinion) }

    before do
      Opinion.any_instance.stub(:valid?).and_return validity
      Opinion.any_instance.stub(:thing).and_return thing
    end

    context 'when Opinion is valid' do
      let(:validity) { true }

      context 'when format is HTML' do
        it "creates an opinion, gives a message, and redirects to the page of the Thing about which the opinion was created" do
          post 'create', post_params

          expect(opinion).to be_a Opinion
          expect(opinion).to be_persisted
          expect(response).to redirect_to thing
          expect(flash[:notice]).to eq "Thank you for your opinion!"
        end
      end

      context 'when format is JSON' do
        render_views

        it 'renders certain attributes of the opinion, status is 201, and a message of success' do
          Thing.any_instance.stub(:average_rating).and_return(23.55)
          post 'create', post_params.merge(format: 'json')
          expect(response.response_code).to eq 201

          body = JSON.parse(response.body)
          opinion = body['opinion']
          expect(opinion['rating']).to eq post_params[:opinion][:rating]
          expect(opinion['comment']).to eq post_params[:opinion][:comment]
          expect(opinion['url']).to eq opinion_url(Opinion.first)
          thing = opinion['thing']
          expect(opinion.keys.count).to eq 4

          expect(thing['average_rating']).to eq 23.55
          expect(thing.keys.count).to eq 1
          expect(response.headers['Location']).to eq opinion_url(Opinion.first)
          expect(body['messages']['notice']).to eq "Thank you for your opinion!"
        end
      end
    end

    context 'when Opinion is NOT valid' do
      let(:validity) { false }

      context 'when format is HTML' do
        it "redirects to the page of the Thing about which the opinion was created with an alert message" do
          post 'create', post_params

          expect(opinion).to be_a Opinion
          expect(response).to redirect_to thing
          expect(flash[:alert]).to eq "Could not handle your opinion!"
        end
      end

      context 'when format is JSON' do
        render_views

        it 'renders status 400 and an alert' do
          post 'create', post_params.merge(format: 'json')
          body = JSON.parse response.body
          expect(body['messages']['alert']).to eq "Could not handle your opinion!"
          expect(body.keys.count).to eq 1
          expect(response.response_code).to eq 400
        end
      end
    end

    describe 'params' do
      context 'when all params are given' do
        it 'assigns them to the Opinion (with current_user.id to user_id)' do
          post 'create', post_params

          expect(opinion.thing_id).to eq thing.id
          expect(opinion.rating).to eq 5
          expect(opinion.comment).to eq 'Awesome'
          expect(opinion.user_id).to eq current_user.id
        end
      end

      context 'when a stray parameter is given' do
        it 'silently rejects those parameters' do
          Opinion.should_receive(:new).with('thing_id' => thing.id.to_s, 'user' => current_user).and_call_original
          post 'create', { opinion: { thing_id: thing.id, bullshit: 'something' } }
        end
      end
    end
  end

  describe "PATCH 'update'" do
    let(:opinion_variable) { assigns(:opinion) }
    let(:opinion) { FactoryGirl.create :opinion }
    let(:patch_params) { post_params.merge(id: opinion.id) }

    before do
      Opinion.should_receive(:find).with(opinion.id.to_s).and_return(opinion)
      opinion.stub(:valid?).and_return validity
      Opinion.any_instance.stub(:thing).and_return thing
    end

    context 'when Opinion is valid' do
      let(:validity) { true }

      context 'when format is HTML' do
        it "creates an opinion, gives a message, and redirects to the page of the Thing about which the opinion was created" do
          patch 'update', patch_params

          expect(opinion_variable).to be_a Opinion
          expect(opinion_variable.changes).to be_empty
          expect(opinion_variable.comment).to eq 'Awesome'
          expect(response).to redirect_to thing
          expect(flash[:notice]).to eq "Thank you for your opinion!"
        end
      end

      context 'when format is JSON' do
        render_views

        it 'renders certain attributes of the opinion, status is 200, and a message of success' do
          Thing.any_instance.stub(:average_rating).and_return(23.55)

          patch 'update', patch_params.merge(format: 'json')
          expect(response.response_code).to eq 200

          body = JSON.parse(response.body)
          opinion = body['opinion']
          expect(opinion['rating']).to eq post_params[:opinion][:rating]
          expect(opinion['comment']).to eq post_params[:opinion][:comment]
          expect(opinion['url']).to eq opinion_url(Opinion.first)
          thing = opinion['thing']
          expect(opinion.keys.count).to eq 4

          expect(thing['average_rating']).to eq 23.55
          expect(thing.keys.count).to eq 1
          expect(response.headers['Location']).to eq opinion_url(Opinion.first)
          expect(body['messages']['notice']).to eq "Thank you for your opinion!"
        end
      end
    end

    context 'when Opinion is NOT valid' do
      let(:validity) { false }

      context 'when format is HTML' do
        it "redirects to the page of the Thing about which the opinion was created with an alert message" do
          patch 'update', patch_params

          expect(opinion_variable).to be_a Opinion
          expect(opinion_variable.changes).not_to be_empty
          expect(response).to redirect_to thing
          expect(flash[:alert]).to eq "Could not update your opinion!"
        end
      end

      context 'when format is JSON' do
        context 'when format is JSON' do
          render_views

          it 'renders status 400 and an alert' do
            patch 'update', patch_params.merge(format: 'json')
            body = JSON.parse response.body
            expect(body['messages']['alert']).to eq "Could not update your opinion!"
            expect(body.keys.count).to eq 1
            expect(response.response_code).to eq 400
          end
        end
      end
    end
  end
end
