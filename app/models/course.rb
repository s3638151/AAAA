class Course < ApplicationRecord
    validates :name, presence: true
    validates_length_of :name, :minimum => 10
    validates :prerequisite, presence: true
    validates_length_of :prerequisite, :minimum => 10
    validates :description, presence: true
    validates_length_of :description, :minimum => 30

    has_and_belongs_to_many :categories
    has_and_belongs_to_many :locations
    belongs_to :user
    has_many :votes

    def thumbs_up
        self.votes.where(:vote => 1).count
    end

    def thumbs_down
        self.votes.where(:vote => 0).count
    end
end
