class User < ActiveRecord::Base
  has_secure_password

  has_many :auctions, dependent: :nullify
  has_many :bids, dependent: :nullify
  has_many :bidded_auctions, through: :bids, source: :auctions

  def full_name
    "#{first_name} #{last_name}"
  end
end
