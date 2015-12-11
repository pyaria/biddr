class AuctionsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

  def index
    @auction = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = current_user.auctions.new params.require(:auction).permit([:title,
                                                            :details,
                                                            :ends_on,
                                                            :reserve_price])
    if @auction.save
      redirect_to auction_path(@auction)
    else
      render :new
    end
  end

  def show
    @auction = Auction.find params[:id]
    @bid = Bid.new
    @bids = @auction.bids.order("created_at desc")
  end
end
