class Office < ApplicationRecord
  include FlagShihTzu
  belongs_to :specialist, foreign_key: 'user_id', dependent: :destroy
  has_many :staffs, dependent: :destroy
  has_many_attached :images

  def image_url
    helpers = Rails.application.routes.url_helpers
    if images.blank?
      return
    else
      helpers.url_for(images)
    end
  end

  has_flags(
    1 => :sunday,
    2 => :monday,
    3 => :tuesday,
    4 => :wednesday,
    5 => :thursday,
    6 => :friday,
    7 => :saturday
  )

end