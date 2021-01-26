require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  index = 0 
  while index < coupons.length 
    cart_item = find_item_by_name_in_collection(coupons[index][:item], cart)
    item_name = coupons[index][:item]
    couponed_item_name = "#{item_name} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
      if cart_item && cart_item[:count] >= coupons[index][:num]
        if cart_item_with_coupon
          cart_item_with_coupon[:count] += coupons[index][:num]
          cart_item[:count] -= coupons[index][:num]
        else
         cart_item_with_coupon = {
           :item => couponed_item_name,
           :price => coupons[index][:cost] / coupons[index][:num],
           :clearance => cart_item[:clearance],
           :count => coupons[index][:num]
          }
          cart << cart_item_with_coupon
          cart_item[:count] -= coupons[index][:num]
        end
     end
     index += 1 
  end
  cart
end


def apply_clearance(cart)
  index = 0
  while index < cart.length 
    if cart[index][:clearance]
      cart[index][:price] = (cart[index][:price] * 0.80).round(2)
    end
    index += 1 
  end
  cart  
end


def checkout(cart, coupons)
  total = 0 
  new_cart = consolidate_cart(cart) 
  coupon_cart = apply_coupons(new_cart, coupons) 
  final_cart = apply_clearance(coupon_cart) 
  index = 0 
    while index < final_cart.length
      total += final_cart[index][:price] * final_cart[index][:count]
      index += 1
   end 
   if total > 100.00 
     total = (total * 0.9) 
   end
   total
end
