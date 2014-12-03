class User < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  has_many :journeys, dependent: :destroy

  # ==[ Devise ]================================================================
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  #def self.find_for_database_authentication(warden_conditions)
    #conditions = warden_conditions.dup
    #if login = conditions.delete(:login)
      #where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    #else
      #where(conditions).first
    #end
  #end
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  validates :username,
    uniqueness: { case_sensitive: false },
    length: {minimum: 3, maximum: 50}


  # ==[ Following ]=============================================================
  acts_as_follower
  acts_as_followable

  # ==[ Searching ]=============================================================
  searchable do
    text :email
    time :created_at
  end
end
