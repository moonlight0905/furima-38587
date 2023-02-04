require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe '購入記録新規登録' do
    before do
      @purchase = FactoryBot.build(:purchase)
    end

    context '内容に問題ない場合' do
      it 'user,itemが存在すれば登録できる' do
        expect(@purchase).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'userが紐づいていないと保存できないこと' do
        @purchase.user = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("User must exist")
      end
      it 'itemが紐づいていないと保存できないこと' do
        @purchase.item = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Item must exist")
      end
    end
  end
end