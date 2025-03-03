namespace :set_reading_time_on_tasks do
  desc 'Update Reading Time'
  # 'form_populate:call['file_name', 'workspace']'

  task call: :environment do
    Task.all.each do |task|
      content_words_count = task.content.split(' ').count
      reading_time = content_words_count / 200
      task.update(reading_time:reading_time)
    end
  end
end
