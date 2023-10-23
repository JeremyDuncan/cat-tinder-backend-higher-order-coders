# app/models/cat_image.rb
class CatImage < ApplicationRecord
  belongs_to :cat
  mount_uploader :image, CatImageUploader
end
