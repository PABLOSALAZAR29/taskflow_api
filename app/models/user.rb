class User < ApplicationRecord
  has_secure_password

  # Validaciones
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, length: { minimum: 6 }, if: :password_required?

  # Enum correcto para Rails 8
  enum :role, { user: 0, admin: 1 }, default: :user

  # Método para generar JWT
  def generate_jwt
    payload = { 
      user_id: id,
      exp: 24.hours.from_now.to_i 
    }
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  private

  def password_required?
    new_record? || password.present?
  end
end