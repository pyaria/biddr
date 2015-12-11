class Auction < ActiveRecord::Base
  validates :title, presence: true
  validates :details, presence: true
  validates :ends_on, presence: true
  validate :future_event
  validates :reserve_price, presence: true

  belongs_to :user
  has_many :bids, dependent: :nullify
  has_many :bidding_users, through: :bids, source: :user

  include AASM

  aasm :whiny_transitions => false do
    state :published, initial: true
    state :reserve_met
    state :won
    state :cancelled
    state :reserve_not_met

    event :bid_over do
      transitions from: :published, to: :reserve_met
    end
  end

  private

  def future_event
    if ends_on.present?
      errors.add(:ends_on, "Can't be in the past!") if ends_on < Time.now
    else
      errors.add(:ends_on, "Must be present!")
    end
  end
end
