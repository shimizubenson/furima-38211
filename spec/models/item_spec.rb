require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
      @item = FactoryBot.build(:item)
  end

    describe "商品の出品" do
     context '商品の出品がうまくいくとき' do
       it "imageとnameとdescriptionとstatus_idとcategory_idとpostage_idとregion_idとday_to_ship_idとpriceが投稿ができた場合" do
        expect(@item).to be_valid
        
       end  
      end

    context '商品の出品ができない場合' do
      it "imageが空だと登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end

      it "nameが空だと登録できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it "descriptionが空だと登録できない" do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it "status_idが未選択項目だと登録できない" do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end

      it "category_idが未選択項目だと登録できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it "postage_idが未選択項目だと登録できない" do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end

      it "region_idが未選択項目だと登録できない" do
        @item.region_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it "day_to_ship_idが未選択項目だと登録できない" do
        @item.day_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it "priceが空だと登録できない" do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end

      it "priceが¥300より少ないと登録できない" do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
      end

      it "priceが¥9999999より高いと登録できない" do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
      end

      it "priceが全角数字では登録できない" do
        @item.price = '２０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")  
      end

      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
