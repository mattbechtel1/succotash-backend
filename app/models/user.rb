class User < ApplicationRecord
    has_secure_password :password
    validates :username, uniqueness: {case_sensitive: false}
    has_many :fields
    has_many :beds, through: :fields
    has_many :stages, through: :beds
end
