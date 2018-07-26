class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  AVAILABLE_ROLES = %w(manager editor viewer).freeze

  scope :viewer, -> { where(role: "viewer") }
  scope :editor, -> { where(role: "editor") }
  scope :manager, -> { where(role: "manager") }

  AVAILABLE_ROLES.each do |query_role|
    define_method "#{query_role}?" do
      role == query_role
    end
  end

  class << self
    def available_roles
      AVAILABLE_ROLES
    end
  end
end
