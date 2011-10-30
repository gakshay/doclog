class Transaction < ActiveRecord::Base

  validates_presence_of :sender_mobile
  validates_numericality_of :sender_mobile, :only_integer => true, :allow_nil => true
  validates_format_of :sender_mobile, :with => /(^[789][0-9]{9}$)|(^91[789][0-9]{9}$)/i, :allow_blank => true
  
  validates_presence_of :receiver_mobile, :if => :receiver_mobile_required?
  validates_numericality_of :receiver_mobile, :only_integer => true, :if => :receiver_mobile_required?
  validates_format_of :receiver_mobile, :with => /(^[789][0-9]{9}$)|(^91[789][0-9]{9}$)/i, :allow_blank => true
 
  validates_presence_of :receiver_email, :if => :receiver_email_required?
  validates_format_of :receiver_email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :allow_blank => true

  #validates_presence_of :document_id
  belongs_to :document
  accepts_nested_attributes_for :document
 
  def self.get_document(mobile, email, secure_code)
    unless (mobile.blank? or email.blank?) and secure_code.blank?
      transaction = Transaction.where("(sender_mobile = ? OR receiver_mobile = ? OR receiver_email = ?) AND document_secret = ?", mobile, mobile, email, secure_code)
      transaction.first unless transaction.blank?
    else
      record.errors.add(document_secret, "secret is wrong") if secure_code.blank?

    end
  end

  
  # model hooks
  before_create :assign_sender, :assign_receiver, :generate_document_secret
  after_create :deliver_document_secret_sms, :send_recipient_email

  def assign_sender
    user = User.find_by_mobile(self.sender_mobile, :select => "id")
    self.sender_id = user.id unless user.blank?
  end

  def assign_receiver
    user = User.where("mobile = ? or email = ?", self.receiver_mobile, self.receiver_mobile).select("id, mobile, email").first
    self.receiver_id = user.id unless user.blank?
    self.receiver_mobile = user.mobile unless user.blank?
    self.receiver_email = user.email unless user.blank?
  end

  def generate_document_secret
    self.document_secret = Time.now.to_i.to_s(36)
  end

  def deliver_document_secret_sms
    # code to send sms to sender and receiver
  end
  
  def send_recipient_email
    unless self.receiver_email.blank?
      TransactionMailer.send_recipient_email(self).deliver
    end
  end

  protected
  
  def receiver_mobile_required?
    self.receiver_email.blank?
  end

  def receiver_email_required?
    self.receiver_mobile.blank?
  end
end
