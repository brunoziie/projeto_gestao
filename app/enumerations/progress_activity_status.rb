class ProgressActivityStatus < EnumerateIt::Base
  associate_values waiting: 1, doing: 2, doing_late: 3, done: 4, done_late: 5, scheduled: 6, scheduled_late: 7
end

