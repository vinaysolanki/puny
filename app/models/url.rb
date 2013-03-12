class Url < ActiveRecord::Base
  attr_accessible :hits, :key, :url
  validates :url, :presence => true
  validates :key, :presence => true, :uniqueness => true
end
