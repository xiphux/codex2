class Author < ActiveRecord::Base
  attr_accessible :email, :name, :website
  has_and_belongs_to_many :fics
end
