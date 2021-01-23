require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  #con_cart = consolidate_cart(cart)
  cart_out = cart
  i = 0 
  while i < cart.length do
    name = cart[i][:item]
    coupon_index = coupons.find_index{|x| x[:item] == name}
    if coupon_index != nil 
      count = cart[i][:count]
      num = coupons[coupon_index][:num]
      if count >= num
        new_price = coupons[coupon_index][:cost]/num
        cart_out[i][:count] = count - num
        discounted_hash = {
          item: "#{name} W/COUPON",
          price: new_price,
          clearance: cart[i][:clearance],
          count: num
        }
        cart_out.push(discounted_hash)
      end
    end
  i += 1   
  end
  # cart_out.delete_if{ |z| z[:count] == 0}
  #binding.pry
  cart_out
end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart_out = cart
  cart.each do |x|
    if x[:clearance] == true
      x[:price]=x[:price]*0.8
      x[:price].round(2)
    end
  end
  cart_out
  
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  con_cart = consolidate_cart(cart)
  coup_cart = apply_coupons(con_cart, coupons)
  ready_cart = apply_clearance(coup_cart)
  total = 0 
  ready_cart.each do |x|
    sub_total = x[:price]*x[:count]
    total = total + sub_total
  end
  if total > 100
    total = total * 0.9
  end
  total = total.round(2)
  total
  
end
