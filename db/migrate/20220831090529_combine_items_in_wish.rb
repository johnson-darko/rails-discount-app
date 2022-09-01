class CombineItemsInWish < ActiveRecord::Migration[7.0]
  def up
    Wish.all.each do |wish|
      sums = wish.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          wish.line_items.where(product_id: product_id).delete_all

          item = wish.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    #split items with a quantity of 1 or more into multiple items
    LineItem.where("quantity>1").each do |line_item|
      line_item.quantity.times do
        LineItem.create(
          wish_id: line_item.wish_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end
      # remove original line item
      line_item.destroy
    end
  end
end
