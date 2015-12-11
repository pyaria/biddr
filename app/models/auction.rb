class Auction < ActiveRecord::Base
  validates :title, presence: true
  validates :details, presence: true
  validates :ends_on, presence: true
  validate :future_event
  validates :reserve_price, presence: true

  private

  def future_event
    if ends_on.present?
      errors.add(:ends_on, "Can't be in the past!") if ends_on < Time.now
    else
      errors.add(:ends_on, "Must be present!")
    end
  end
end
