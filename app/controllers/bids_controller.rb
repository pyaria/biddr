class BidsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

  def new
  end

  def create
    @auction = Auction.find params[:auction_id]
    if @auction.user == current_user
      redirect_to auction_path(@auction), alert: "No bidding on your own auction!"
    else
      @bid = current_user.bids.new(params.require(:bid).permit([:amount]))
      if @auction.bids === [] || @bid.amount > @auction.bids.last.amount
        @bid.auction = @auction
        respond_to do |format|
          if @bid.save
            if @bid.amount > @auction.reserve_price
              @auction.bid_over
              @auction.reserve_price = @bid.amount
              @auction.save
            end
            format.js { render :bid_success, bid: @bid }
            format.html { redirect_to auction_path(@auction), notice: "Bidded!" }
          else

            format.html { redirect_to auction_path(@auction), alert: "Unable to bid!" }
          end
        end
      else
        redirect_to auction_path(@auction), alert: "Unable to bid!"
      end
    end
  end
end
