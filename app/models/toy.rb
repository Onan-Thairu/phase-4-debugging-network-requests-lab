class Toy < ApplicationRecord
  validates :name, :image, presence: true
end
