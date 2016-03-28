class ProgressProjectStatus < EnumerateIt::Base
  associate_values plan: 1, in_progress: 2, finished: 3
end
