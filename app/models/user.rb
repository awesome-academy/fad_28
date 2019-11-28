class User < ApplicationRecord
  has_many :evaluates, dependent: :destroy
  has_many :suggests, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable, :lockable, :timeoutable, :trackable,
    :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  validates :name, presence: true, length: {maximum: Settings.size.of_name}
  validates :phone, numericality: true, allow_nil: true

  before_save{email.downcase!}

  enum role_id: {admin: 1, customer: 2, employee: 3}

  mount_uploader :image, ImageUploader

  def self.from_omniauth auth
    result = User.find_by email: auth.info.email
    return result if result
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.provider = auth.provider
      user.uid = auth.uid
      user.skip_confirmation!
    end
  end
end
