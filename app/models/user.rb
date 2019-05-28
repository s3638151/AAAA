class User < ApplicationRecord
    validates :name, presence: true
    validates_length_of :name, :minimum => 4
    validates :email, presence: true, format: /\w.\w@rmit.edu.au/
    validates_length_of :email, :minimum => 4
    has_secure_password

    has_many :courses

    def is_admin?
        types == 1
    end
end
