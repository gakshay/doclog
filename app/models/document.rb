class Document < ActiveRecord::Base
#  validates :sender_mobile, :presence => true, :numericality => true, :format => { :with => mobile_number_format }
#  validates :receiver_mobile, :presence => true, :numericality => true, :format => { :with => mobile_number_format }


  has_attached_file :doc, :use_timestamp => true

  validates_attachment_presence :doc
  validates_attachment_content_type :doc, :content_type => [ 'image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'application/msword', 'application/pdf' ]
  validates_attachment_size :doc, :less_than => 5.megabyte, :if => Proc.new { |imports| !imports.doc_file_name.blank? }
  
  belongs_to :user
  has_many :transactions

  protected

  def mobile_number_format
    /(^[789][0-9]{9}$)|(^91[789][0-9]{9}$)/i
  end
end
