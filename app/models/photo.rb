class Photo < ActiveRecord::Base
  belongs_to :item
  attr_accessible :caption, :image
  has_attached_file :image, :styles => { :medium => "500x500>", :thumb => "100x100>" }
end
