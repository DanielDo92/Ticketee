class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :tickets, dependent: :delete_all #if destroy has callbacks, use :destroy
end
