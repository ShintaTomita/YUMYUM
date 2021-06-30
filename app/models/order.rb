# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user,   dependent: :destroy
  belongs_to :recipe, dependent: :destroy
end
