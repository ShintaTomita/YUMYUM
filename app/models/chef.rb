# frozen_string_literal: true

class Chef < ApplicationRecord
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,   :registerable,
         :recoverable, :rememberable, :validatable

  with_options on: :step1 do
    validates      :password,              confirmation: true
    validates      :password_confirmation, presence: true
  end

  with_options on: :step2 do
    validates      :name,         presence: true
    validates      :image,        presence: true
    validates      :introduction, presence: true
    validates      :shop_name,    presence: true
    validates      :shop_tel,     presence: true
  end

  has_many :recipes, dependent: :destroy
end
