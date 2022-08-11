require 'rails_helper'

RSpec.describe OrderOrderInformation, type: :model do
  describe '商品購入の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_order_information = FactoryBot.build(:order_order_information, item_id: item.id, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_order_information).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @order_order_information.building_name = ''
        expect(@order_order_information).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと登録できないこと' do
        @order_order_information.post_code = ''
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_order_information.post_code = '1234567'
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end

      it "region_idが未選択項目だと登録できない" do
        @order_order_information.region_id = 1
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Region can't be blank")
      end

      it 'cityが空だと登録できない' do
        @order_order_information.city = ''
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空だと登録できない' do
        @order_order_information.address = ''
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Address can't be blank")
      end

      it "phone_numberが全角数字では登録できない" do
        @order_order_information.phone_number = '２０００００００００'
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Phone number is not a number")  
      end

      it 'phone_numberが10桁より少ないと登録できない' do
        @order_order_information.phone_number = '123456789'
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが11桁より大きいと登録できない' do
        @order_order_information.phone_number = '123456789012'
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが空だと登録できない' do
        @order_order_information.phone_number = ''
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'userが紐付いていないと保存できない' do
        @order_order_information.user_id = nil
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できない' do
        @order_order_information.item_id = nil
        @order_order_information.valid?
        expect(@order_order_information.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

