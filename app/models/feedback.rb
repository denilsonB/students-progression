class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :task
  before_save :set_avaliation

  def set_avaliation
    av = 0
    av = 1 if  self.note == "Acima do meu nível" 
    av = -1  if self.note == "Abaixo do meu nível"
    
      self.avaliation = av
  end
end
