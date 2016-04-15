namespace :migration_times do
  desc "Passa o valor de init_time da atividade para o historico"
  task :init_time => :environment do
    Activity.where.not(init_time: nil).each do |act|
      historical = act.historicals.find_by(historic_type: HistoricalType::INITIATE)
      historical.timetable = act.init_time

      historical.save
      puts historical.timetable
    end
  end

  task :finish_time => :environment do
    Activity.where.not(finish_time: nil).each do |act|
      historical = act.historicals.find_by(historic_type: HistoricalType::FINISHED)
      historical.timetable = act.finish_time

      historical.save
      puts historical.id
      puts historical.timetable
    end
  end

  task :create_time => :environment do
    Activity.where.not(init_time: nil).each do |act|
      historical = act.historicals.find_by(historic_type: HistoricalType::CREATED)
      historical.timetable = act.created_at

      historical.save
      puts historical.timetable
    end
  end

  task :created_time => :environment do
    Historical.where(timetable: nil).each do |hist|
      act = hist.activity

      hist.timetable = act.created_at

      hist.save
    end
  end


end
