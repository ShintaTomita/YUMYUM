# frozen_string_literal: true

class Recipe < ApplicationRecord
  mount_uploader :main_image, ImageUploader
  mount_uploader :first_image, ImageUploader
  mount_uploader :second_image, ImageUploader
  mount_uploader :third_image, ImageUploader
  mount_uploader :fourth_image, ImageUploader

  belongs_to :chef, dependent: :destroy
  belongs_to :genre
  has_one    :order, dependent: :destroy
  has_many   :posts, dependent: :destroy

  def self.search(search)
    return Recipe.all unless search

    Recipe.where(['name LIKE? OR food_stuff LIKE?', "%#{search}%", "%#{search}%"])
  end
end
