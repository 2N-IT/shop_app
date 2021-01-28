# frozen_string_literal: true

class Order < ApplicationRecord
  validates :country, inclusion: { in: COUNTRIES, message: '%{value} is not a valid country' }
  validates :zip_code, format: { with: /(?i)\A[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]\z/, message: 'must be a zip_code/postal code' }
  validates :name, :city, :street, :country, :province, presence: true
  validates :payment_method, inclusion: %w[cash card transfer online]
  validates :delivery_method, inclusion: %w[ups gls dpd fedex postal]

  belongs_to :user
  has_many :product_items
end
