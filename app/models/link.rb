class Link < ApplicationRecord
  validates :name, uniqueness: { scope: [:name] }
end
