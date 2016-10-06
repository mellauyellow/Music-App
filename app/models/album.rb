class Album < ActiveRecord::Base
  ALBUM_STATUS = %w(live studio)

  validates :band_id, :name, :status, presence: true
  validates :status, inclusion: ALBUM_STATUS

  belongs_to :band,
    class_name: :Band,
    primary_key: :id,
    foreign_key: :band_id

  has_many :tracks,
    class_name: :Track,
    primary_key: :id,
    foreign_key: :album_id,
    dependent: :destroy
end
