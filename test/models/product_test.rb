require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title:       "My Book Title",
                          description: "yyy",
                          image_url:   "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title:       "My Book Title",
                description: "yyy",
                price:       1,
                image_url:   image_url)
  end
  test "image url" do
    ok = %w{ natasha.jpg natasha.png NATASHA.JPG NATASHA.Jpg
             http://a.b.c/x/y/z/natasha.jpg }
    bad = %w{ natasha.doc natasha.jpg/more natasha.jpg.more }
    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title:       products(:art).title,
                          description: "yyy", 
                          price:       1, 
                          image_url:   "natasha.jpg")

    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title:       products(:art).title,
                          description: "yyy", 
                          price:       1, 
                          image_url:   "natasha.jpg")

    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:title]
  end
  
  test "product title must be at least ten characters long" do
    product = products(:art)
    assert product.valid?, "product title shouldn't be invalid" 
    
    product.title = product.title.first(9)
    assert product.invalid?, "product title shouldn't be valid"
  end
end
