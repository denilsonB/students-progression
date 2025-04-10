class Task < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :classroom

  has_many :task_progresses
  has_many :feedbacks

  enum grade_level: { fifth_grade: 0, sixth_grade: 1, seventh_grade: 2, eighth_and_nineth_grade: 3,tenth_to_twelveth_grade: 4, college: 5, college_graduate: 6, professional: 7 }
  validates :grade_level, presence: true

  before_save :set_reading_time 

  TRANSLATED_GRADES =     { 
    "fifth_grade" => "Quinta Série",
    "sixth_grade" => "Sexta Série",
    "seventh_grade" => "Setima Série", 
    "eighth_and_nineth_grade" => "Oitava e Nona Série",
    "tenth_to_twelveth_grade" => "Ensino Médio", 
    "college" => "Faculdade", 
    "college_graduate" => "Graduado em faculdade", 
    "professional" => "Profissional"
  }

  def set_reading_time
    content_words_count = self.content.split(' ').count
    reading_time = content_words_count / 200
    self.reading_time = reading_time
  end
end
