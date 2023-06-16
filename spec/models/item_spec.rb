require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品情報登録' do
    context '出品情報を登録できる場合' do
      it 'item_name, text, price, category_id, condition_id, shipping_cost_id, prefecture_id, days_to_ship_id, imagesが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '出品情報を登録できない場合' do
      it 'imagesが空では登録できない' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('画像を入力してください')
      end
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it 'textが空では登録できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it 'category_idが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを入力してください')
      end
      it 'condition_idが空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を入力してください')
      end
      it 'shipping_cost_idが空では登録できない' do
        @item.shipping_cost_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を入力してください')
      end
      it 'prefecture_idが空では登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を入力してください')
      end
      it 'days_to_ship_idが空では登録できない' do
        @item.days_to_ship_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を入力してください')
      end
      it 'category_idに「---」が選択されている場合は出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーは不正な値です')
      end
      it 'condition_idに「---」が選択されている場合は出品できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態は不正な値です')
      end
      it 'shipping_cost_idに「---」が選択されている場合は出品できない' do
        @item.shipping_cost_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担は不正な値です')
      end
      it 'prefecture_idに「---」が選択されている場合は出品できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域は不正な値です')
      end
      it 'days_to_ship_idに「---」が選択されている場合は出品できない' do
        @item.days_to_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数は不正な値です')
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('価格を入力してください')
      end
      it 'priceが300円未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は¥300 ~ ¥9,999,999の半角数値で入力してください')
      end
      it 'priceが9,999,999円より高ければ登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は¥300 ~ ¥9,999,999の半角数値で入力してください')
      end
      it 'priceが半角数値でなければ登録できない' do
        @item.price = '五百円'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は¥300 ~ ¥9,999,999の半角数値で入力してください')
      end
      it 'ユーザーが紐付いていなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
