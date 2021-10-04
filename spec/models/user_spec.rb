require 'rails_helper'

# @userをセットアップ
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

    # ユーザー新規登録についてのテストコードを記述
    # 対象：ユーザー新規登録
  describe '新規登録' do
    context '新規登録できるとき' do
      it '新規登録が正常にできる' do        
        expect(@user).to be_valid
      end
      
    end
  
    context '新規登録できないとき' do
      it 'nicknameが存在しない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが存在しない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが重複している' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに＠が入っていない' do
        @user.email = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'PWが存在しない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password is invalid")
      end
      it '確認用PWが一致しない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'PWが6文字以上の英数字の組み合わせではない' do
        @user.password = 'test'
        @user.password_confirmation = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'PWは数字のみでは登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation doesn't match Password")
      end
      it 'PWは英字のみでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'PWは全角では登録できない' do
        @user.password = 'ああああア亜'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
      end
      it '苗字が存在しない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid")
      end
      it '苗字が日本語以外' do
        @user.last_name = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it '名前が存在しない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end
      it '名前が日本語以外' do
        @user.last_name = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it '苗字（カナ）が存在しない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana is invalid")
      end
      it '苗字（カナ）に全角カナ以外の記述がある' do
        @user.last_name_kana = 'aあｱ亜'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it '名前（カナ）が存在しない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid")
      end
      it '名前（カナ）に全角カナ以外の記述がある' do
        @user.first_name_kana = 'aあｱ亜'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it '生年月日が存在しない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end

  describe 'ユーザーログイン' do
    context 'ログインできるとき' do
      it 'メールアドレス、PW一致' do
        @user.password = '1@1'
        @user.password = 'test12345'
        expect(@user).to be_valid
      end
    end
    
    context 'ログインできないとき' do  
        # expect(@user.errors.full_messages).to include()
      
      it 'メールアドレスが登録されていない' do
        @user.password = 'hoge@hoge'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
      end
      it 'PWが存在しない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password is invalid", "Password confirmation doesn't match Password")
      end
      it 'PWが一致しない' do
        @user.password = 'test67890'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end