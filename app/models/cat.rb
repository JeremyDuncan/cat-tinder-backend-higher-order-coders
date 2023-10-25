class Cat < ApplicationRecord
  has_many :cat_images, dependent: :destroy
  accepts_nested_attributes_for :cat_images, allow_destroy: true, reject_if: proc { |attributes| attributes['image'].blank? }

  validates :name, :age, :enjoys, presence: true
  validates :enjoys, length: { minimum: 10 }
end
