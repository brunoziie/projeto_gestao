class HistoricalType < EnumerateIt::Base
  associate_values created: 1, initiate: 2, finished: 3, paused: 4, restarted: 5
end

