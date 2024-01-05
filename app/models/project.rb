class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy # or whatever association options you need
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank
end
