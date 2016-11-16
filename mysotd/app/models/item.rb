class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :shaving_items
  has_many :shaving_records, :through => :shaving_items

  has_attached_file :equipment_picture, styles:{medium: "300x300>", thumb: "100x100>"}, default_url: "missing/items/:style/missing.png"
  validates_attachment_content_type :equipment_picture, content_type: /\Aimage\/.*\z/
end
