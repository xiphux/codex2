class Author < ActiveRecord::Base
  attr_accessible :email, :name, :website
  has_and_belongs_to_many :fics

  scope :with_keyword, lambda { |keyword| keyword.present? ? {:conditions => ["authors.name LIKE ?", "%" + keyword + "%"]} : {} }

  def to_s
    self.name
  end
end
