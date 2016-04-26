class ProgressActivityStatus < EnumerateIt::Base
  associate_values waiting: 1, doing: 2, done: 3, paused: 4, restarted: 5
end

