class User < ApplicationRecord
  has_secure_password

  validates :password,
    format: {
      with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d\W]{8,}\z/,
      message: 'は8文字以上で、大文字・小文字・数字をそれぞれ1文字以上含めてください'
    },
    if: -> { password.present? }  # 編集時に空で通すため

    has_many :posts, dependent: :destroy
end
