require_relative './part_1_solution.rb'

cart_test = [
  {:item => "BEER", :price => 13.00, :clearance => false},
  {:item => "BEER", :price => 13.00, :clearance => false},
  {:item => "BEER", :price => 13.00, :clearance => false}
]
coupons_test = [
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "BEER", :num => 2, :cost => 20.00}
]

def apply_coupons(cart, coupons)
  #cart = [{:item=>"AVOCADO", :price=>3.0, :clearance=>true, :count=>3},{:item=>"KA...}]
  coupons.map { |coupon|
    if find_item_by_name_in_collection(coupon[:item], cart)
    item = find_item_by_name_in_collection(coupon[:item], cart)
      if coupon[:num] === nil
      elsif item[:count] >= coupon[:num]
        item[:count] -= coupon[:num]
        coupon[:item] = "#{coupon[:item]} W/COUPON"
        coupon[:price] = coupon[:cost] / coupon[:num]
        coupon[:clearance] = item[:clearance]
        coupon[:count] = coupon[:num]
        coupon.delete(:num)
        coupon.delete(:cost)
        cart.push(coupon)
      end
    end
  }
  #pp cart
  cart
end

#apply_coupons(consolidate_cart(cart_test), coupons_test)

def apply_clearance(cart)
  cart.map { |item|
    if item[:clearance] === true
      item[:price] *= 0.8
      item[:price] = item[:price].round(2)
    end
  }
  #pp cart
  cart
end

#apply_clearance(consolidate_cart(cart_test))

def checkout(cart, coupons)
  total_price = 0
  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  cart.map { |item|
    item_total = item[:price] * item[:count]
    item_total
    total_price += item_total
  }
  if total_price >= 100
    total_price *= 0.9
  end
  pp total_price
  total_price
end

checkout(cart_test, coupons_test)
