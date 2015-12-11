class AuctionsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

  def index
    @auction = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new params.require(:auction).permit([:title,
                                                            :details,
                                                            :ends_on,
                                                            :reserve_price])
    @auction.user = current_user
    if @auction.save
      redirect_to auction_path(@auction)
    else
      render :new
    end
  end

  def show
    @auction = Auction.find params[:id]
  end
end
