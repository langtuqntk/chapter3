class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

=begin
  attr_accessor :image
  #added for paperclip-drop gem
  has_attached_file :image,
                    :storage => :dropbox,
                    :dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
                    :styles => { :medium => "300x300" , :thumb => "100x100>"},
                    :dropbox_options => {
                        :path => proc { |style| "#{style}/#{id}_#{image.original_filename}"},       :unique_filename => true
                    }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

#  validates :image, :attachment_presence => true
=end
  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
