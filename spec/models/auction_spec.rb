require 'rails_helper'

RSpec.describe Auction, type: :model do
  describe "validations" do
    it "requires a title" do
      auction = Auction.new(ends_on: Faker::Date.forward(23))
      auction.valid?
      expect(auction.errors.messages).to have_key(:title)
    end

    it "requires details" do
      auction = Auction.new(ends_on: Faker::Date.forward(23))
      auction.valid?
      expect(auction.errors.messages).to have_key(:details)
    end

    it "requires an end_date" do
      auction = Auction.new
      auction.valid?
      expect(auction.errors.messages).to have_key(:ends_on)
    end
    it "requires an end_date in the future" do
      auction = Auction.new(ends_on: "December 10 2015")
      auction.valid?
      expect(auction.errors.messages).to have_key(:ends_on)

    end
    it "requires a reserve price" do
      auction = Auction.new(ends_on: "December 10 2015")
      auction.valid?
      expect(auction.errors.messages).to have_key(:reserve_price)
    end
  end
end
