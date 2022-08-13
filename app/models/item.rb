class Item < ApplicationRecord

         validates :name, :description,:image,             presence: true
         validates :status_id, numericality: { other_than: 1, message: "を入力してください" }
         validates :category_id, numericality: { other_than: 1,message: "を入力してください" }
         validates :postage_id, numericality: { other_than: 1,message: "を入力してください" }
         validates :region_id, numericality: { other_than: 1,message: "を入力してください" }
         validates :day_to_ship_id, numericality: { other_than: 1,message: "を入力してください" } 
         validates :price, presence: true, numericality: { only_integer: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
                                             
         extend ActiveHash::Associations::ActiveRecordExtensions
         belongs_to :user
         belongs_to :status
         belongs_to :category
         belongs_to :postage
         belongs_to :region
         belongs_to :day_to_ship
         has_one_attached :image
         has_one    :order
end
