# frozen_string_literal: true

class Recipe < ApplicationRecord
  mount_uploader :main_image,   ImageUploader
  mount_uploader :first_image,  ImageUploader
  mount_uploader :second_image, ImageUploader
  mount_uploader :third_image,  ImageUploader
  mount_uploader :fourth_image, ImageUploader

  validates      :name,           presence: true
  validates      :food_stuff,     presence: true
  validates      :main_image,     presence: true
  validates      :chef_id,        presence: true
  validates      :genre_id,       presence: true
  validates      :advise,         presence: true
  validates      :first_process,  presence: true
  validates      :second_process, presence: true
  validates      :first_image,    presence: true
  validates      :second_image,   presence: true

  belongs_to     :chef
  belongs_to     :genre
  has_one        :order,  dependent: :destroy
  has_many       :posts,  dependent: :destroy

  def self.search(search)
    return Recipe.all unless search

    Recipe.where(['name LIKE? OR food_stuff LIKE?', "%#{search}%", "%#{search}%"])
  end
end
