class Entry < ActiveRecord::Base
  #extend ::Geocoder::Model::ActiveRecord

  belongs_to :journey
  belongs_to :user

  validates :title, presence: true, length: {maximum: 250}
  validates :body, presence: true, length: {maximum: 10000}
  validates :journey_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :user_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :latitude, presence: true, numericality: {greater_than: -90.0, less_than: 90.0}
  validates :longitude, presence: true, numericality: {greater_than: -180.0, less_than: 180.0}

  # ==[ Search ]================================================================
  searchable do
    text :title
    text :body
    date :created_at
  end

  # ==[ Geocoding ]=============================================================
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.country = geo.country
      obj.state = geo.state
    end
  end

  after_validation :reverse_geocode, if: ->(obj){ 
    not obj.country.present? or obj.country_changed?
  }

  # ==[ Commenting ]============================================================
  acts_as_commentable
end
