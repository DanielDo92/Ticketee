class Ticket < ActiveRecord::Base
  belongs_to :project
  validates :name, presence: true
  validates :description, presence: true, length: {maximum: 100, minimum: 10}
end
