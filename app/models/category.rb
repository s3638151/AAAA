class Category < ApplicationRecord
    validates :name, presence: true
    validates_length_of :name, :minimum => 4

    has_and_belongs_to_many :courses
end
