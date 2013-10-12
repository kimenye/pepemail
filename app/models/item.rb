class Item < ActiveRecord::Base
  attr_accessible :description, :list_price, :name, :type
end
