class User < ApplicationRecord
  before_destroy :ensure_admin
validates :name,  presence: true, length: { maximum: 30 }
before_validation { email.downcase! }
validates :email, presence: true, :uniqueness => true, length: { maximum: 255 },
                   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
 validates :password, presence: true, length: { minimum: 6 }
 has_secure_password
 has_many :tasks, dependent: :destroy
 private
 def ensure_admin
     if User.where(admin: true).count <= 1 && self.admin == true
      throw(:abort)
    end
  end
end
