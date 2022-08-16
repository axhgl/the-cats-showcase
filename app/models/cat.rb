class Cat < ApplicationRecord
  belongs_to :breed, counter_cache: true

  validates :remote_id, :url, :width, :height, presence: true
  validates :remote_id, :url, uniqueness: true

  paginates_per 10

  scope :by_breed_name, -> (breed_name) {
    joins(:breed).
    where(breed: { name: breed_name }).
    order(created_at: :desc).
    includes(:breed)
  }

  scope :by_newest, -> (page) {
    includes(:breed).
    order(created_at: :desc).
    page(page)
  }
end
