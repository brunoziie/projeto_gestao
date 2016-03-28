class ProgressSprintStatus < EnumerateIt::Base
  associate_values doing: 1, doing_late: 2, finished: 3, finished_late: 4, scheduled: 5, scheduled_late: 6
end

