class User < ActiveRecord::Base
  #deprecated in rails 4
  #attr_accessible :email, :name, :photo, :major, :password, :password_confirmation
  has_many :companies
  
  #connections
  has_many :connections, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :connections, source: :followed
  has_many :reverse_connections, foreign_key: "followed_id",
                                   class_name:  "Connection",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_connections, source: :follower
  #profile photo
  #attr_accessor :photo
  #attr_accessor :photo_file_name
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "30X30>" }, :default_url => "/assets/missing_:style.png"

  has_secure_password


  before_save { email.downcase! } #does this need { }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 } 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_UMICH_EMAIL = /\A[\w+\-.]+@umich.edu/i
  validates :email, presence: true, 
  					#format: { with: VALID_UMICH_EMAIL },
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def following?(other_user)
    connections.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    connections.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    connections.find_by_followed_id(other_user.id).destroy
  end

  private
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end


end
