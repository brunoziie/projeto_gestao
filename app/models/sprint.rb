class Sprint < ActiveRecord::Base
  extend EnumerateIt

  after_create :increment_number
  after_create :update_status_on_create

  belongs_to :project

  has_enumeration_for :status, with: ProgressSprintStatus, create_helpers: true

  def start_sprint
    self.update_attribute(:status, ProgressSprintStatus::DOING)
    #TODO colocar datetime em que foi iniciado
  end

  def finish_sprint
    self.update_attribute(:status, ProgressSprintStatus::FINISHED)
    #TODO colocar datetime em que foi finalizado
  end

  def late?
    if self.status == ProgressSprintStatus::SCHEDULED
      if self.init_date <= Date.today
        true
      else
        false
      end
    elsif self.status == ProgressSprintStatus::FINISHED
      #TODO REVER REGRA
      if self.end_date < Date.today
        true
      else
        false
      end
    else
      if self.end_date < Date.today
        true
      else
        false
      end
    end
  end

private
  def increment_number
    maximum = Sprint.maximum(:number)
    maximum.nil? ? self.number = 1 : self.number = (maximum += 1)
    self.save
  end

  def update_status_on_create
    self.update_attribute(:status, ProgressSprintStatus::SCHEDULED)
  end
end
