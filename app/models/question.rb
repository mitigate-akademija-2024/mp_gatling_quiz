class Question < ApplicationRecord
    validates :question_text, presence: true

    def correct_answer
        answer.where(:correct => true)
    end

    has_many :answers, dependent: :destroy
    belongs_to :quiz
end