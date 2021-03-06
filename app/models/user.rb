# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options on: :step1 do
    validates      :password, confirmation: true
    validates      :password_confirmation, presence: true
  end

  has_one :card,    dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :posts,  dependent: :destroy
end
