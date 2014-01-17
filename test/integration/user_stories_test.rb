require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  
  #Empty  orders and line_items table before we start
  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    art_drawing = products(:art)
    
    # A user goes to the index page.
    get "/"
    assert_response :success
    assert_template "index"
    
    #They select a product, adding it to their cart.
    xml_http_request :post, '/line_items', product_id: art_drawing.id
    assert_response :success 
    
    #Their cart contains the product.
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal art_drawing, cart.line_items[0].product
    
    #They check out...
    get "/orders/new"
    assert_response :success
    assert_template "new"
    
    #filling in their details on the checkout form. When they submit...
    post_via_redirect "/orders",
                      order: { name:     "Stephania Thomas",
                               address:  "123 Best Street",
                               email:    "stephania@programmer.org",
                               pay_type: "Check" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size
    
    #An order is created containing their information, along with a
    #single line item corresponding to the product they added to their cart.
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    
    assert_equal "Stephania Thomas",      order.name
    assert_equal "123 Best Street",   order.address
    assert_equal "stephania@programmer.org", order.email
    assert_equal "Check",            order.pay_type
    
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal art_drawing, line_item.product

    #Verify that the email is correctly addressed and has the expected subject line.
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["stephania@programmer.org"], mail.to
    assert_equal "Art <depot@example.com>", mail[:from].value
    assert_equal "Pragmartistic Store Order Confirmation", mail.subject
  end

end

