class Item < ApplicationRecord

         validates :name,              presence: true
         validates :description,       presence: true
         validates :status_id,         presence: true
         validates :category_id,       presence: true 
         validates :postage_id,        presence: true 
         validates :region_id,         presence: true
         validates :day_to_ship_id,    presence: true
         validates :price,             presence: true
         
         belongs_to :user
         has_one_attached :image
end