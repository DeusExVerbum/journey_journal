class Entry < ActiveRecord::Base
  belongs_to :journey

  validates :title, presence: true, length: {maximum: 250}
  validates :body, presence: true, length: {maximum: 10000}
  validates :journey_id, presence: true, numericality: {only_integer: true, greater_than: 0}
end
