class AuctionsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new params.require(:auction).permit([:first_name,
                                                            :last_name,
                                                            :email,
                                                            :password,
                                                            :password_confirmation])
    @auction.save
    render nothing: true
  end
end
