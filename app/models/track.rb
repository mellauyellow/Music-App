class Track < ActiveRecord::Base
  TRACK_STATUS = %w(bonus regular)

  validates :album_id, :name, :status, presence: true
  validates :status, inclusion: TRACK_STATUS

  belongs_to :album,
    class_name: :Album,
    primary_key: :id,
    foreign_key: :album_id

  has_one :band,
    through: :album,
    source: :band
end
