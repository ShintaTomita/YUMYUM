class Recipe < ApplicationRecord
  
  serialize :process, Array
  serialize :images, Array
end
