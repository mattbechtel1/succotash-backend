class User < ApplicationRecord
    has_secure_password :password
    validates :username, uniqueness: {case_sensitive: false}
    validates_format_of :username, with: /\A[a-zA-Z0-9]*\z/, on: :create, message: 'Username is invalid. Please use only alphanumeric characters.'
    validates_length_of :username, within: 4..25, on: :create
    validates_length_of :password, within: 6..25, on: [:create, :update]
    has_many :fields
    has_many :beds, through: :fields
    has_many :stages, through: :beds
    has_many :todos
    has_many :favorites
    has_many :crops, through: :favorites
end
