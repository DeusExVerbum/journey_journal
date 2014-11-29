class Entry < ActiveRecord::Base
  belongs_to :journey
  belongs_to :user

  validates :title, presence: true, length: {maximum: 250}
  validates :body, presence: true, length: {maximum: 10000}
  validates :journey_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :user_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :latitude, presence: true, numericality: {greater_than: -90.0, less_than: 90.0}
  validates :longitude, presence: true, numericality: {greater_than: -180.0, less_than: 180.0}
end
