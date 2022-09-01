class Product < ApplicationRecord
  belongs_to :store

  validates :name, presence: true
  before_destroy :not_referenced_by_any_line_item
  has_many :line_items

  private

   def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line items present')
      throw :abort
    end
   end

end
