require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#create' do
    before do
      @room = FactoryBot.build(:room)
    end

    context 'ルーム作成ができる時' do
      it 'nameの値が存在すれば作成できること' do
        expect(@room).to be_valid
      end
    end

    context 'ルーム作成ができない時' do
      it 'nameの値が存在しないと登録できないこと' do
        @room.name = ''
        @room.valid?
        expect(@room.errors.full_messages).to include("Name can't be blank")
      end
    end
  end
end
