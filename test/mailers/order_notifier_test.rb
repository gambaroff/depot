require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Pragmartistic Store Order Confirmation", mail.subject
    assert_equal ["stephania@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /1 x  Mr.President/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Pragmartistic Store Order Shipped", mail.subject
    assert_equal ["stephania@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Mr.President<\/td>/,
      mail.body.encoded
  end

end