class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :mobile, :email, :password, :password_confirmation, :remember_me
  
  validates_presence_of  :mobile, :if => :mobile_required?
  validates_format_of    :mobile, :with => /(^0?[789][0-9]{9}$)|(^91[789][0-9]{9}$)/i, :allow_blank => true 
  validates_uniqueness_of :mobile, :allow_blank => true
  validates_numericality_of :mobile, :only_integer => true, :allow_nil  => true

  validates_format_of :password, :with => /(^[0-9]{4,12}$)/i, :allow_blank => true

  before_create :create_email_for_user

  def create_email_for_user
    self.email = "#{self.mobile}@edakia.in" unless self.mobile.blank?
  end
  
  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    mobile = conditions.delete(:mobile)
    where(conditions).where(["lower(mobile) = :value", { :value => mobile.downcase }]).first
  end

  def email_required?
   false
  end
  
  def mobile_required?
    true
  end

end
