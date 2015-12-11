require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:auction) { FactoryGirl.create(:auction, user: user) }

  describe "#create" do
    context "with user not signed in" do
      it "redirects to user sign in page" do
        post :create, auction_id: auction, bid: {amount: 10}
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with user signed in" do
      before do
        u = FactoryGirl.create(:user)
        request.session[:user_id] = u.id
      end

      it "allows user to save bid" do
        post :create, auction_id: auction, bid: {amount: 10}
        expect(response).to redirect_to(auction_path(auction))
      end

    end

  end
end
