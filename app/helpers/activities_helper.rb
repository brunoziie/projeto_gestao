module ActivitiesHelper
  def historical_helper historical
    if historical.historic_type == 1
      "[#{historical.created_at.strftime("%d/%m/%Y %H:%M")}] Atividade Criada por #{historical.user.name}"
    elsif historical.historic_type == 2
      "[#{historical.created_at.strftime("%d/%m/%Y %H:%M")}] Atividade Iniciada por #{historical.user.name}"
    else
      "[#{historical.created_at.strftime("%d/%m/%Y %H:%M")}] Atividade Finalizada por #{historical.user.name}"
    end
  end
  def pretty_duration activity
    milli = activity.finish_time - activity.init_time

    parse_string = (milli < 3600 ? '%M:%S' : '%H:%M:%S')

    Time.at(milli).utc.strftime(parse_string)
  end
  def pretty_doing_duration activity
    milli = Time.now - activity.init_time

    parse_string = (milli < 3600 ? '%M:%S' : '%H:%M:%S')

    Time.at(milli).utc.strftime(parse_string)
  end
end
