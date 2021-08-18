require 'rails_helper'

RSpec.describe 'ユーザーログイン機能', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザーがログインできるとき' do
    it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
      #トップページへ遷移する
      visit root_path
      #ログインしていない場合、サインインページへ遷移していることを確認する
      expect(current_path).to eq(new_user_session_path)
    end

    it 'ログインに成功し、トップページへ遷移する' do
      # あらかじめ、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      sign_in(@user)

    end
  end

  context 'ユーザーがログインできないとき' do
    it 'ログインに失敗し、再びサインインページに戻ってくる' do
      # あらかじめ、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      # トップページに遷移する
      visit root_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq(new_user_session_path)
      # 誤ったユーザー情報を入力する
      fill_in 'Email' , with: @user.email+"誤った情報を入力"
      fill_in 'Password' , with: @user.password+"Fail"
      # binding.pry
      # ログインボタンをクリックする
      click_on 'Log in'
      # サインインページに戻ってきていることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
