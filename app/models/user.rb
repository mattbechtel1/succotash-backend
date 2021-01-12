class User < ApplicationRecord
    has_secure_password :password
    has_secure_token :reset_password_token
    validates :username, uniqueness: {case_sensitive: false}
    validates_format_of :username, with: /\A[a-zA-Z0-9]*\z/, on: :create, message: 'Username is invalid. Please use only alphanumeric characters.'
    validates_length_of :username, within: 4..25, on: :create
    validates_length_of :password, within: 6..25, on: [:create, :update], unless: Proc.new { |a| !a.new_record? && a.password.blank? }
    validates :email, 
        format: { with: /(.+)@(.+)/, message: "Email invalid"  },
        uniqueness: { case_sensitive: false },
        length: { minimum: 4 }   
    has_many :fields
    has_many :beds, through: :fields
    has_many :stages, through: :beds
    has_many :todos
    has_many :favorites
    has_many :crops, through: :favorites

    def generate_password_token!
        self.reset_password_token = generate_token
        self.reset_password_sent_at = Time.now.utc
        byebug
        save!
    end

    def send_dummy_email!
        UserMailer.password_reset_email(self).deliver_now
    end

    def password_token_valid?
        (self.reset_password_sent_at + 4.hours) > Time.now.utc
    end

    private
    
    def generate_token
        SecureRandom.base58(5)
    end
end
