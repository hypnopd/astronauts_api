class Astronaut < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :age, numericality: { only_integer: true, allow_nil: true }
end
