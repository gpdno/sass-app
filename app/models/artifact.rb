class Artifact < ApplicationRecord
  belongs_to :project

  validates_presence_of :name, :upload
  validates_uniqueness_of :name
  validate :uploaded_file_size

  attr_accessor :upload
  MAX_FILESIZE = 10.megabytes

  private

  def uploaded_file_size
    if upload
      errors.add(:upload, "File size must be less than #{self.class::MAX_FILESIZE}") 
      unless upload.size <= self.class::MAX_FILESIZE
    end
  end

  def upload_to_s3
    s3 = Aws::S3::Resource.new(region:'us-west-2')
    obj = s3.bucket('bucket-name').object('key')
    obj.upload_file('/path/to/source/file')
  
end
