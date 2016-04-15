module ActivitiesHelper
  def historical_helper historical
    if historical.historic_type == 1
      "[#{historical.timetable.strftime("%d/%m/%Y %H:%M")}] Atividade Criada por #{historical.user.name}"
    elsif historical.historic_type == 2
      "[#{historical.timetable.strftime("%d/%m/%Y %H:%M")}] Atividade Iniciada por #{historical.user.name}"
    else
      "[#{historical.timetable.strftime("%d/%m/%Y %H:%M")}] Atividade Finalizada por #{historical.user.name}"
    end
  end

  def pretty_duration activity
    if activity.finished_date && activity.initiate_date
      milli = activity.finished_date - activity.initiate_date

      parse_string = (milli < 3600 ? '%M:%S' : '%H:%M:%S')

      Time.at(milli).utc.strftime(parse_string)
    end
  end

  def pretty_doing_duration activity
    if activity.initiate_date
      milli = Time.now - activity.initiate_date

      parse_string = (milli < 3600 ? '%M:%S' : '%H:%M:%S')

      Time.at(milli).utc.strftime(parse_string)
    end
  end
end
