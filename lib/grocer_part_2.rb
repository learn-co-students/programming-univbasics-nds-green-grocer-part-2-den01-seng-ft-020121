require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  # want to take the cart and check to see if any items in the cart will match up for the coupon, if so need to see if >= coup amoun
  # if so will subtract from the count and add a new item to the cart (so will need ot have new hash made), will need to take cost / num
  # then push it to the new cart 

  cart.each do |item_pre_coup|
    coupons.each do |coupon|
      new_coupon_item = {}
      if coupon[:item] == item_pre_coup[:item]
        if item_pre_coup[:count] >= coupon[:num]
          new_coupon_item[:item] = "#{item_pre_coup[:item]} W/COUPON"
          new_coupon_item[:price] = coupon[:cost] / coupon[:num]
          new_coupon_item[:clearance] = item_pre_coup[:clearance]
          new_coupon_item[:count] = coupon[:num]
          cart.push(new_coupon_item)
          item_pre_coup[:count] -= coupon[:num]
        end
      end
    end
  end
  return cart
end




def apply_clearance(cart)

=begin
  {:item => "PEANUT BUTTER", :price => 2.40, :clearance => true,  :count => 2},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
  {:item => "SOY MILK", :price => 3.60, :clearance => true,  :count => 1}
Sometimes, these operations can lead to numbers with many decimal places. The
`Float` class' built-in [round][round] method will be helpful here to make sure
your values align. `2.4900923090909029304` becomes `2.5` if we use it like so:
`2.4900923090909029304.round(2)`
=end
  #take .20 off 

  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item_in_cart|
    if item_in_cart[:clearance] == true
      item_in_cart[:price] = item_in_cart[:price] - (item_in_cart[:price] * 0.20)
      item_in_cart[:price].round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs

  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  grand_total = 0
  conso_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(conso_cart, coupons)
  final_cart = apply_clearance(coupon_cart)

  final_cart.each do |item|
    grand_total += item[:count] * item[:price]
  end
  if grand_total > 100
    grand_total = grand_total - (grand_total * 0.10)
  end

  return grand_total

  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
