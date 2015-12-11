require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:auction) { FactoryGirl.create(:auction, user: user) }

  describe "#new" do
    context "with user not signed in" do
      it "redirects to user sign in page" do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with user signed in" do
      before do
        u = FactoryGirl.create(:user)
        request.session[:user_id] = u.id
        get :new
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "creates a new auction object assigned to `auction` instance variable" do
        expect(assigns(:auction)).to be_a_new(Auction)
      end
    end
  end

  describe "#create" do
    context "with no user signed in" do
      it "redirects to the sign in page" do
        post :create, {auction: {}}
        expect(response).to redirect_to new_session_path
      end
    end

    context "With user signed in" do
      def valid_params
        FactoryGirl.attributes_for(:auction)
      end

      before do
        request.session[:user_id] = user.id
      end

      context "with valid parameters" do
        it "creates an auction record in the database" do
          before_count = Auction.count
          post :create, auction: valid_params
          after_count  = Auction.count
          expect(after_count - before_count).to eq(1)
        end

        it "associates the auction with the signed in user" do
          post :create, auction: valid_params
          expect(Auction.last.user).to eq(user)
        end

      #   it "redirects to campaign show page" do
      #     post :create, campaign: valid_params
      #     expect(response).to redirect_to(campaign_path(Campaign.last))
      #   end
      # end
      # context "with invalid parameters" do
      #   def request_with_invalid_title
      #     post :create, campaign: valid_params.merge({title: nil})
      #   end
      #
      #   it "doesn't create a campaign record in the database" do
      #     # expect { request_with_invalid_title }.not_to change { Campaign.count }
      #     before_count = Campaign.count
      #     request_with_invalid_title
      #     after_count  = Campaign.count
      #     expect(before_count).to eq(after_count)
      #   end
      #
      #   it "renders the new template" do
      #     request_with_invalid_title
      #     expect(response).to render_template(:new)
      #   end
      end

  end
  end
end
