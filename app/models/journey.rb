class Journey < ActiveRecord::Base
  has_many :entries

  validates :title, presence: true, length: {maximum: 250}
  validates :description, presence: true, length: {maximum: 10000}
end
