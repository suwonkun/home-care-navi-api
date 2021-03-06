class Staff < ApplicationRecord
  belongs_to :office
  has_many :care_recipients, dependent: :destroy
  has_one_attached :image
  has_many :thanks, dependent: :destroy

  def image_url
    helpers = Rails.application.routes.url_helpers
    if image.blank?
      return
    else
      helpers.url_for(image)
    end
  end
end
