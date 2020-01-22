require 'pp'

test_cart =   [
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "KALE", :price => 3.00, :clearance => false},
      {:item => "BLACK_BEANS", :price => 2.50, :clearance => false},
      {:item => "ALMONDS", :price => 9.00, :clearance => false},
      {:item => "TEMPEH", :price => 3.00, :clearance => true},
      {:item => "CHEESE", :price => 6.50, :clearance => false},
      # {:item => "BEER", :price => 13.00, :clearance => false},
      {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
      {:item => "TEMPEH", :price => 3.00, :clearance => true},
      {:item => "BEETS", :price => 2.50, :clearance => false},
      {:item => "SOY MILK", :price => 4.50, :clearance => true},
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
      {:item => "AVOCADO", :price => 3.00, :clearance => true}
    ]

test_coupons =  [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 3, :cost => 15.00}
    ]

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  for item in collection do
    if item[:item] === name
      return item
    end
  end
  
  nil
end


def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  consolidated_cart = []
  
  for item in cart do
    name = item[:item] #"PEANUTBUTTER"
    
    if !find_item_by_name_in_collection(name, consolidated_cart)
      item_with_count = item.clone
      item_with_count[:count] = 1
      
      consolidated_cart << item_with_count
    elsif find_item_by_name_in_collection(name, consolidated_cart) #"PEANUTBUTTER"
      item_in_cart = find_item_by_name_in_collection(name, consolidated_cart)
      
      item_in_cart[:count] += 1
    end
    
  end

  return consolidated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  for coupon in coupons do
    name = coupon[:item]
    coupon_amount = coupon[:num]
    item_in_cart = find_item_by_name_in_collection(name, cart)
    
    if item_in_cart && item_in_cart[:count] >= coupon_amount
      # times_coupon_applied = item_in_cart[:count] / coupon_amount
      remainder = item_in_cart[:count] % coupon_amount
      
      discounted_item = item_in_cart.clone
      discounted_item[:item] = "#{name} W/COUPON"
      discounted_item[:price] = coupon[:cost]/coupon[:num]
      discounted_item[:count] -= remainder
      
      cart << discounted_item
      
      item_in_cart[:count] = remainder
    end
  end
  
  return cart
end



def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  for item in cart do
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(2)
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
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  total = 0.0
  
  cart_after_coupons_and_clearance_applied = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  
  for item in cart_after_coupons_and_clearance_applied do
    item_total = item[:price] * item[:count]
    total += item_total
  end
  
  if total > 100
    total *= 0.9
  end
  
  return total.round(2)
end

pp checkout(test_cart, test_coupons)