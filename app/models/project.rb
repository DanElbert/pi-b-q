class Project < ActiveRecord::Base

  validates :name, presence: true
  validates :start, presence: true
  validates :end, presence: true


end
