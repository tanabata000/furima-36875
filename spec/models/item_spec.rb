require 'rails_helper'

# @userをセットアップ
RSpec.describe User, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

    # ユーザー新規登録についてのテストコードを記述
    # 対象：ユーザー新規登録
  describe '出品' do
    context '出品できるとき' do
      it '出品が正常にできる' do        
        expect(@item).to be_valid
      end
    end
  
    context '出品できないとき' do
      it '商品画像が存在しない' do
        # 画像が存在しない場合、値がnilとなるため。文字列ならば''で空欄を入力することで結果的にnilとなる。
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が存在しない' do
        @item.item_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品の説明が存在しない' do
        @item.item_info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item info can't be blank")
      end
      # 商品の詳細
      it 'カテゴリーが未選択' do
        @item.item_category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item category can't be blank")
      end
      it '商品名の状態が未選択' do
        @item.item_sales_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item sales status can't be blank")
      end
      it '配送料の負担が未選択' do
        @item.item_shipping_fee_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item shipping fee status can't be blank")
      end
      it '発送元の地域が未選択' do
        @item.item_prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item prefecture can't be blank")
      end
      it '発送までの日数が未選択' do
        @item.item_scheduled_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item scheduled delivery can't be blank")
      end
      # 販売価格
      it '販売価格が存在しない' do
        @item.item_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price is not included in the list", "Item price is not a number")
      end

      it '販売価格が300円未満' do
        @item.item_price = '200'
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price is not included in the list")
      end
      it '販売価格が9,999,999円を超える' do
        @item.item_price = '99999999'
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price is not included in the list")
      end
      it '販売価格に数字以外が入っている' do
        @item.item_price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price is not included in the list", "Item price is not a number")
      end
    end
  end
end
