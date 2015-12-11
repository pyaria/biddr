module BidsHelper
  def find_auction(auction_id)
    @auction = Auction.find auction_id
    @auction.title
  end
end
