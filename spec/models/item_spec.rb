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
      it 'ユーザーが紐づいていない' do
        # itemレコードに紐づくuserテーブルを参照
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('ユーザーを入力してください')
      end
      it '商品画像が存在しない' do
        # 画像が存在しない場合、値がnilとなるため。文字列ならば''で空欄を入力することで結果的にnilとなる。
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '商品名が存在しない' do
        @item.item_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品の説明が存在しない' do
        @item.item_info = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      # 商品の詳細
      it 'カテゴリーが未選択' do
        @item.item_category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it 'カテゴリーで「---」が選択されている' do
        @item.item_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it '商品名の状態が未選択' do
        @item.item_sales_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it '商品名の状態で「---」が選択されている' do
        @item.item_sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it '配送料の負担が未選択' do
        @item.item_shipping_fee_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it '配送料の負担で「---」が選択されている' do
        @item.item_shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it '発送元の地域が未選択' do
        @item.item_prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it '発送元の地域で「---」が選択されている' do
        @item.item_prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it '発送までの日数が未選択' do
        @item.item_scheduled_delivery_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("配送までの日数を入力してください")
      end
      it '発送までの日数で「---」が選択されている' do
        @item.item_scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送までの日数を入力してください")
      end
      # 販売価格
      it '販売価格が存在しない' do
        @item.item_price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください", "価格は数値で入力してください", "価格は一覧にありません")
      end
      it '販売価格が300円未満' do
        @item.item_price = '200'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は一覧にありません")
      end
      it '販売価格が9,999,999円を超える' do
        @item.item_price = '99999999'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は一覧にありません")
      end
      it '販売価格に数字以外が入っている' do
        @item.item_price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください", "価格は一覧にありません")
      end
    end
  end
end
