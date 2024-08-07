class Quiz < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: true
    
    before_validation :normalize_title
    before_save :normalize_description

    has_many :questions

    protected

    def normalize_title
        Rails.logger.info("Quiz#normalize_title called")
        self.title = self.title.squish.capitalize unless self.title.nil?
    end

    def normalize_description
        Rails.logger.info("Quiz#normalize_description called")
        self.description = self.description.squiish unless self.description.nil?
    end
end
