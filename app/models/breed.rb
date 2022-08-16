class Breed < ApplicationRecord
  has_many :cats, dependent: :destroy

  validates :remote_id, :name, :temperament,
            :origin, :description, :child_friendly,
            presence: true
  validates :remote_id, :name, uniqueness: true

  scope :by_name_search, -> (term) { where("name ILIKE ?", "%#{term}%") }
end
