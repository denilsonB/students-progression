module TasksHelper
  def progress_text(grade_user,grade_task)
    grade_levels =  { 'fifth_grade'=> 0,
    'sixth_grade' => 1, 'seventh_grade' => 2, 'eighth_and_nineth_grade' => 3, 'tenth_to_twelveth_grade' => 4, 'college' => 5, 'college_graduate' => 6, 'professional' => 7 }
    difference = grade_levels[grade_user] - grade_levels[grade_task]
    if difference <= -2
      "Este é um texto muito acima do seu Nivel. O texto é adequado para alunos nível "
    elsif difference == -1
      "Este é um texto um pouco acima do seu Nivel. O texto é adequado para alunos nível "
    elsif difference >= 2
      "Este é um texto muito abaixo do seu Nivel. O texto é adequado para alunos nível "
    elsif difference == -1
      "Este é um texto um pouco abaixo do seu Nivel. O texto é adequado para alunos nível "
    else
      "Este é um texto adequado pro seu Nível. Texto nível " 
    end
  end

  def task_progress_class(progress)
    if progress == 0
      'progress-red'
    elsif progress > 0 && progress < 100
      'progress-blue'
    else
      'progress-green'
    end
  end
end
