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

# def apply_coupons(cart, coupons)
#     coupons.each do |coupon_hash|
#       if (cart.keys.include?(coupon_hash[:item]))
#         if (cart[coupon_hash[:item]][:count] >= coupon_hash[:num])
#           cart[coupon_hash[:item]][:count] -= coupon_hash[:num]
#           if (cart.keys.include? ("#{coupon_hash[:item]} W/COUPON"))
#             cart["#{coupon_hash[:item]} W/COUPON"][:count] += 1 
#           else 
#             couponed_item = {}
#             couponed_item["#{coupon_hash[:item]} W/ COUPON"] = {:price => coupon_hash[:cost], :clearance => cart[coupon_hash[:item]][:clearance], :count => 1}
#             cart = cart.merge(couponed_item)
#           end 
#         else 
#           return cart 
#         end 
#       else 
#         return cart 
#       end 
#     end 
#     return cart
# end
def apply_coupons(cart, coupons)
  
  #check if coupon array has elements
  if coupons.length > 0
    
    #iterate through coupon array
    coupons.each do |n|
      
      #see if coupon item is in the cart
      if (cart.keys.include? (n[:item])) 
        
        #see if cart item qty is > coupon qty
        if cart[n[:item]][:count] >=  n[:num]
        
          #decrease cart item quantity
          cart[n[:item]][:count] -= n[:num]
  
          
          #see if we need to add coupon line item to cart or increase existing coupon line item
          if cart.keys.include? ("#{n[:item]} W/COUPON")
            
            cart["#{n[:item]} W/COUPON"][:count] += 1
          else 
          #convert coupon structure to cart_hash structure and merge into cart
          coupon_hash = {}
          coupon_hash["#{n[:item]} W/COUPON"] = {:price => n[:cost], :clearance => cart[n[:item]][:clearance], :count => 1}
          cart = cart.merge(coupon_hash)
          end
        else 
          return cart
        end 
      else 
        return cart
      end 
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
