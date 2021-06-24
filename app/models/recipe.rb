class Recipe < ApplicationRecord
  mount_uploader :main_image, ImageUploader
  mount_uploader :first_image, ImageUploader
  mount_uploader :second_image, ImageUploader
  mount_uploader :third_image, ImageUploader
  mount_uploader :fourth_image, ImageUploader

  belongs_to :chef
  has_one    :order, dependent: :destroy
end
