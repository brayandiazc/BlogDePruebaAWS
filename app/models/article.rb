class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: %w[draft published] }
  validates :category, presence: true

  validate :image_type_and_size

  private
  def image_type_and_size
    return unless image.attached?
    if !image.content_type.in?(%w[image/jpeg image/png image/webp image/gif])
      errors.add(:image, 'debe ser un archivo JPG, PNG, WEBP o GIF')
    end
    if image.byte_size > 2_097_152
      errors.add(:image, 'debe ser menor a 2MB')
    end
  end
end
