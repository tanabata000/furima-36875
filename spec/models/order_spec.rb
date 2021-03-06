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
      it '建物名がなくても登録できる' do
        @order.building = nil
        expect(@order).to be_valid
      end
    end

    context '購入できないとき' do
      it '購入者（ユーザー）情報が存在しない' do
        # itemレコードに紐づくuserテーブルを参照
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("ユーザーを入力してください")
      end
      it '商品情報が存在しない' do
        # itemレコードに紐づくuserテーブルを参照
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("商品情報を入力してください")
      end
      it 'トークン情報が存在しない' do
        # itemレコードに紐づくuserテーブルを参照
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it '郵便番号が存在しない' do
        @order.postal_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は不正な値です")
      end
      it '郵便番号にハイフンがない' do
        @order.postal_code = '1111111'
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '郵便番号の桁が少ない' do
        @order.postal_code = '111-111'
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '郵便番号の桁が多い' do
        @order.postal_code = '1111-1111'
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '郵便番号が数字以外' do
        @order.postal_code = 'aaa'
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '都道府県が存在しない' do
        @order.item_prefecture_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("都道府県を入力してください", "都道府県を入力してください")
      end
      it '都道府県で「---」が選択されている' do
        @order.item_prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("都道府県を入力してください")
      end
      it '市区町村が存在しない' do
        @order.city = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が存在しない' do
        @order.addresses = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が存在しない' do
        @order.phone_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です")
      end
      it '電話番号が数字以外' do
        @order.phone_number = 'Phone number is invalid'
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '電話番号が9桁以下の場合' do
        @order.phone_number = '111111111'
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '電話番号が12桁以上の場合' do
        @order.phone_number = '111111111111'
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は不正な値です")
      end
    end
  end
end
