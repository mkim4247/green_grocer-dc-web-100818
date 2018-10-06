def consolidate_cart(cart)
  final_hash = {}
  count = Hash.new(0)
  cart.each do |hash|
    count[hash] += 1 
  end 
  
  count.collect do |hash, value|
    hash.collect do |item, info_hash|
      final_hash[item] = info_hash
      final_hash[item][:count] = value
    end 
  end 
  final_hash 
end

def apply_coupons(cart, coupons)
    coupons.each do |coupon_hash|
      if (cart.keys.include?(coupon_hash[:item]))
        if (cart[coupon_hash[:item]][:count] >= coupon_hash[:num])
          cart[coupon_hash[:item]][:count] -= coupon_hash[:num]
          if (cart.keys.include? ("#{coupon_hash[:item]} W/COUPON"))
            cart["#{coupon_hash[:item]} W/COUPON"][:count] += 1 
          else 
            couponed_item = {}
            couponed_item["#{coupon_hash[:item]} W/ COUPON"] = {:price => coupon_hash[:cost], :clearance => cart[coupon_hash[:item]][:clearance], :count => 1}
            cart = cart.merge(couponed_item)
          end 
        else 
          return cart 
        end 
      else 
        return cart 
      end 
    end 
    return cart
end


def apply_clearance(cart)
  cart.collect do |item_name, info_hash|
    if cart[item_name][:clearance] == true 
      cart[item_name][:price] = (cart[item_name][:price] * 0.80).round(2)
    end
  end 
  cart 
end

# def checkout(cart, coupons)
#   # code here
# end
