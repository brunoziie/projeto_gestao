class ProgressActivityStatus < EnumerateIt::Base
  associate_values waiting: 1, doing: 2, done: 3
end

