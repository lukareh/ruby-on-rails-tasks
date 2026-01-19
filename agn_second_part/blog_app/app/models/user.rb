class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # checking if user is admin
  def admin?
    admin
  end

  # Hardcoded admin credentials - ensures admin user always exists
  ADMIN_EMAIL = 'hdlukare@gmail.com'.freeze
  ADMIN_NAME = 'Harish Lukare'.freeze
  ADMIN_PASSWORD = 'Harish123'.freeze

  # Class method to ensure admin user exists
  def self.ensure_admin_exists!
    admin = find_or_initialize_by(email: ADMIN_EMAIL)
    
    if admin.new_record?
      admin.assign_attributes(
        name: ADMIN_NAME,
        password: ADMIN_PASSWORD,
        password_confirmation: ADMIN_PASSWORD,
        admin: true
      )
      admin.save!
      Rails.logger.info "✓ Hardcoded admin created: #{admin.name}"
    else
      # Ensure existing user has correct attributes
      updates = {}
      updates[:admin] = true unless admin.admin?
      updates[:name] = ADMIN_NAME unless admin.name == ADMIN_NAME
      admin.update!(updates) if updates.any?
    end
    
    admin
  end
end
