require 'rails_helper'

RSpec.describe PurchaseDestination, type: :model do
  describe '発送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_destination = FactoryBot.build(:purchase_destination, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'postal_code, prefecture_id, locality, address, building_name, phone, purchase_id,tokenが存在すれば登録できる' do
        expect(@purchase_destination).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @purchase_destination.building_name = ''
        expect(@purchase_destination).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'postal_codeが空では保存できないこと' do
        @purchase_destination.postal_code = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが「3桁ハイフン4桁」の半角文字列でなければ保存できないこと' do
        @purchase_destination.postal_code = '1234567'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idが空では保存できないこと' do
        @purchase_destination.prefecture_id = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idに「---」が選択されている場合は保存できないこと' do
        @purchase_destination.prefecture_id = 0
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'localityが空だと保存できないこと' do
        @purchase_destination.locality = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Locality can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @purchase_destination.address = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Address can't be blank")
      end
      it 'phoneが空だと保存できないこと' do
        @purchase_destination.phone = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneが9桁以下では保存できないこと' do
        @purchase_destination.phone = '090123456'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('Phone は10ケタか11ケタの半角数値で入力してください')
      end
      it 'phoneが12桁以上では保存できないこと' do
        @purchase_destination.phone = '090123456789'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('Phone は10ケタか11ケタの半角数値で入力してください')
      end
      it 'phoneに半角数字以外が含まれている場合は保存できないこと' do
        @purchase_destination.phone = '090-1234-5678'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('Phone は10ケタか11ケタの半角数値で入力してください')
      end
      it 'tokenが空では保存できないこと' do
        @purchase_destination.token = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
