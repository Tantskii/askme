require 'openssl'

class User < ApplicationRecord
  # Параметры работы модуля шифрования
  ITERATIONS = 20000
  DIGEST     = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :username, length: {maximum: 40}
  validates :username, format: {with: /\A[a-zA-Z0-9_]+\z/}
  validates :email, format: {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
  validates :color, format: {with: /\#([a-f]|[0-9]){6}/i}

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_validation do
    self.username = self.username.downcase
    self.email    = self.email.downcase
  end

  before_save :encrypt_password, :check_color

  def encrypt_password
    if self.password != nil
      self.password_salt =
          User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(self.password,
                                     self.password_salt,
                                     ITERATIONS,
                                     DIGEST.length,
                                     DIGEST)
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email)

    if user.present? && user.password_hash ==
        User.hash_to_string(
            OpenSSL::PKCS5.pbkdf2_hmac(password,
                                       user.password_salt,
                                       ITERATIONS,
                                       DIGEST.length,
                                       DIGEST)
        )

      user
    else
      nil
    end
  end
end
