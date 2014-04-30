class Wiki < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  belongs_to :user

  has_many :collaborations, dependent: :destroy
  accepts_nested_attributes_for :collaborations, allow_destroy: true
  
  has_many :users, through: :collaborations, dependent: :destroy
  
  def self.pub
     where(private: false)
  end

end
