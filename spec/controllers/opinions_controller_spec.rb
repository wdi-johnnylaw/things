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

      it "creates an opinion, gives a message, and redirects to the page of the Thing about which the opinion was created" do
        post 'create', post_params

        expect(opinion).to be_a Opinion
        expect(opinion).to be_persisted
        expect(response).to redirect_to thing
        expect(flash[:notice]).to eq "Thank you for your opinion!"
      end
    end

    context 'when Opinion is NOT valid' do
      let(:validity) { false }

      it "redirects to the page of the Thing about which the opinion was created with an error message" do
        post 'create', post_params

        expect(opinion).to be_a Opinion
        expect(response).to redirect_to thing
        expect(flash[:error]).to eq "Could not handle your opinion!"
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
end
