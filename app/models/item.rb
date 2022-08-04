class Item < ApplicationRecord

         validates :name, :description, :price,            presence: true
         validates :status_id, numericality: { other_than: 1, message: "can't be blank" }
         validates :category_id, numericality: { other_than: 1,message: "can't be blank" }
         validates :postage_id, numericality: { other_than: 1,message: "can't be blank" }
         validates :region_id, numericality: { other_than: 1,message: "can't be blank" }
         validates :day_to_ship_id, numericality: { other_than: 1,message: "can't be blank" } 
         
         belongs_to :user
         belongs_to :status
         belongs_to :category
         belongs_to :postage
         belongs_to :region
         belongs_to :day_to_ship
         has_one_attached :image
end
