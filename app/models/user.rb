class User < ApplicationRecord
  has_many :activities

  enum role: [:user, :admin, :vip]
  after_initialize :set_default_role, :if => :new_record?

    def set_default_role
      self.role ||= :user
    end
  
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, and :omniauthable :registerable,
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :lockable, :trackable, password_length: 10..70

  validate :password_complexity
    def password_complexity
      if password.present? and not password.match(/\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/)
        errors.add :password, "must include at least one lowercase letter, one uppercase letter, and one digit"
      end
    end

    validates :first_name, presence: true,
    length: { minimum: 2, maximum: 25 }

    validates :last_name, presence: true,
    length: { minimum: 2, maximum: 25 }
  

extend FriendlyId
  friendly_id :uniqueslug, use: :slugged

  def uniqueslug
    "#{first_name}-#{last_name}"
  end

        
end
