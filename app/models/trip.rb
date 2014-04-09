class Trip < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :destination, presence: true
end
