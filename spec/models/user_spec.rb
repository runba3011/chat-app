require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '保存できるとき' do
      it 'nameとemail,password,password_confirmationが存在すれば登録できる' do
        @user.valid?
        expect(@user).to be_valid
      end
      it 'passwordが６文字以上であれば登録できる' do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        expect(@user).to be_valid
      end

    end

    context '保存できないとき' do
      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")

      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが６文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordとpassword_confirmationが不一致の時登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '11111'
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複するemailが存在する場合は登録できない' do
        @second_user = FactoryBot.create(:user)
        @user.email = @second_user.email
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
    end
  end
end
