class Activity < ApplicationRecord
    belongs_to :user

    validates :title, presence: true
    validates :date_field, presence: true
    validates :duration_minutes, presence: true, length: { minimum: 1 }

    extend FriendlyId
     friendly_id :title, use: :slugged
end
