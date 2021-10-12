require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order, user_id: user.id, item_id: item.id)
    # テストに負荷がかかりすぎてread_timeout以内に処理が終わらなかった。
    sleep 0.1
  end
  describe '購入' do
    context '購入できるとき' do
      it '購入が正常にできる' do
        expect(@order).to be_valid
      end
    end

    context '購入できないとき' do
      it '購入者（ユーザー）情報が存在しない' do
        # itemレコードに紐づくuserテーブルを参照
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
      it '商品情報が存在しない' do
        # itemレコードに紐づくuserテーブルを参照
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
      it 'トークン情報が存在しない' do
        # itemレコードに紐づくuserテーブルを参照
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が存在しない' do
        @order.postal_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid')
      end
      it '郵便番号にハイフンがない' do
        @order.postal_code = '1111111'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号の桁が少ない' do
        @order.postal_code = '111-111'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号の桁が多い' do
        @order.postal_code = '1111-1111'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号が数字以外' do
        @order.postal_code = 'aaa'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid')
      end
      it '都道府県が存在しない' do
        @order.item_prefecture_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item prefecture can't be blank")
      end
      it '都道府県で「---」が選択されている' do
        @order.item_prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("Item prefecture can't be blank")
      end
      it '市区町村が存在しない' do
        @order.city = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end
      it '番地が存在しない' do
        @order.addresses = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Addresses can't be blank")
      end
      it '電話番号が存在しない' do
        @order.phone_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
      end
      it '電話番号が数字以外' do
        @order.phone_number = 'Phone number is invalid'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が9桁以下の場合' do
        @order.phone_number = '111111111'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上の場合' do
        @order.phone_number = '111111111111'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
