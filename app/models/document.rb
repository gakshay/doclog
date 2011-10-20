class Document < ActiveRecord::Base

  has_attached_file :doc, :use_timestamp => true
  validates_attachment_presence :doc
  validates_attachment_content_type :doc, :content_type => [ 'image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'application/msword', 'application/pdf' ]
  validates_attachment_size :doc, :less_than => 5.megabyte, :if => Proc.new { |imports| !imports.doc_file_name.blank? }
  
  belongs_to :user
  has_many :transactions

end
