require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'パスワードのバリデーション' do
    context '有効な場合' do
      it '大文字・小文字・数字を含み8文字以上であれば有効' do
        %w[Abcdef12 Password1 TestUser9! A1b2c3d4].each do |pwd|
          user = build(:user, password: pwd, password_confirmation: pwd)
          expect(user).to be_valid, "#{pwd.inspect} は有効なはずです"
        end
      end
    end

    context '無効な場合' do
      it '8文字未満は無効' do
        user = build(:user, password: 'Ab1cD', password_confirmation: 'Ab1cD')
        expect(user).to be_invalid
      end

      it '小文字が含まれないと無効' do
        user = build(:user, password: 'ABCDEFG1')
        expect(user).to be_invalid
      end

      it '大文字が含まれないと無効' do
        user = build(:user, password: 'abcdefg1')
        expect(user).to be_invalid
      end

      it '数字が含まれないと無効' do
        user = build(:user, password: 'Abcdefgh')
        expect(user).to be_invalid
      end

      it '空文字は無効' do
        user = build(:user, password: '')
        expect(user).to be_invalid
      end
    end

    context '編集時（passwordが空の場合）' do
      it 'passwordが空ならバリデーションをスキップする' do
        user = create(:user, password: 'Abcdef12', password_confirmation: 'Abcdef12')
        user.password = ''
        expect(user).to be_valid
      end
    end
  end
end
