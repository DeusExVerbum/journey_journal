class Journey < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: {maximum: 250}
  validates :description, presence: true, length: {maximum: 10000}
  validates :user_id, presence: true, numericality: {only_integer: true, greater_than: 0}
end
