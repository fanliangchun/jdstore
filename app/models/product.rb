class Product < ApplicationRecord
	mount_uploader :image, ImageUploader
	validates :title, presence: true
	belongs_to :category
end
