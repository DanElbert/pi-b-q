class Reading < ActiveRecord::Base

  validates :timestamp, presence: true

  scope :for_project, ->(project) { where('timestamp >= ? AND timestamp <= ?', project.start, project.end).order(:timestamp) }
  scope :after, ->(date) { where('timestamp > ?', date) }

  def to_fahrenheit(v)
    (v * 1.8) + 32
  end

end
