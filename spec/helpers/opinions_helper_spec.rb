require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the OpinionsHelper. For example:
#
# describe OpinionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe OpinionsHelper do
  describe '::rating_percentage(rating)' do
    subject { helper.rating_percentage(rating) }

    context 'when rating is nil' do
      let(:rating) { nil }

      it { should eq 0 }
    end

    context 'when rating is a number' do
      let(:rating) { 4 }

      it { should eq 4/0.0497 }
    end
  end
end
