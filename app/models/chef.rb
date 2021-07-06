# frozen_string_literal: true

class Chef < ApplicationRecord
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,   :registerable,
         :recoverable, :rememberable, :validatable

  with_options on: :step1 do
    validates :name,                  presence: true
    validates :email,                 presence: true
    validates :password,              confirmation: true
    validates :password_confirmation, presence: true
  end

  has_many :recipes, dependent: :destroy
end
