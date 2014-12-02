class User < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  has_many :journeys, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_follower
  acts_as_followable

  searchable do
    text :email
  end
end
