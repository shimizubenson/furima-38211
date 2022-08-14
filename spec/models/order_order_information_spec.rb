require 'rails_helper'

RSpec.describe OrderOrderInformation, type: :model do
  describe '商品購入の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_order_information = FactoryBot.build(:order_order_information, item_id: item.id, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it 'post_codeとregion_idとcityとaddressとphone_numberとtokenが存在すれば登録できる' do
        expect(@order_order_information).to be_valid
      end

      it 'building_nameは空でも登録できる' do
        @order_order_information.building_name = ''
        expect(@order_order_information).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと登録できない' do
        @order_order_information.post_code = ''
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'post_codeが半角のハイフンを含んだ正しい形式でないと登録できない' do
        @order_order_information.post_code = '1234567'
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("郵便番号にハイフォン（-）を入力してください")
      end

      it "region_idが未選択項目だと登録できない" do
        @order_order_information.region_id = 1
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("都道府県を入力してください")
      end

      it 'cityが空だと登録できない' do
        @order_order_information.city = ''
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'addressが空だと登録できない' do
        @order_order_information.address = ''
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("番地を入力してください")
      end

      it "phone_numberが全角数字では登録できない" do
        @order_order_information.phone_number = '２０００００００００'
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("電話番号は不正な値です")  
      end

      it 'phone_numberが10桁より少ないと登録できない' do
        @order_order_information.phone_number = '123456789'
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'phone_numberが11桁より大きいと登録できない' do
        @order_order_information.phone_number = '123456789012'
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'phone_numberが空だと登録できない' do
        @order_order_information.phone_number = ''
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'userが紐付いていないと保存できない' do
        @order_order_information.user_id = nil
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Userを入力してください")
      end

      it 'itemが紐付いていないと保存できない' do
        @order_order_information.item_id = nil
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Itemを入力してください")
      end

      it "tokenが空では登録できないこと" do
        @order_order_information.token = nil
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end

