require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: "Example", last_name: "User", 
                     email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    @second_user = User.new(first_name: "Example_2", last_name: "User_2", 
                            email: "user2@example.com",
                            password: "my_pass", password_confirmation: "my_pass")
  end
  
  test "both users should be valid" do
    assert @user.valid?
    assert @second_user.valid?
  end
  
  test "first name should be present" do
    @user.first_name = ""
    assert_not @user.valid?
  end
  
  test "last name should be present" do
    @user.first_name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "first name should not be too long" do
     @user.first_name = "a" * 26
     assert_not @user.valid?
  end
  
  test "last name should not be too long" do
     @user.first_name = "a" * 36
     assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email should reject invalid addresses" do
    invalid_addresses = %w[user@example,com USER_at_foo.COM A_US-ER@foo
                           first.last@foo_bar.jp alice+bob@baz+bar.cn]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    @user.save
    assert @second_user.valid?
    
    @second_user.email = @user.email
    assert_not @second_user.valid?
  end
  
  test "email addresses should be unique and case-insensitive" do
    @user.save
    assert @second_user.valid?
    
    @second_user.email = @user.email.upcase
    assert_not @second_user.valid?
  end
  
  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should be present and non-blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
end
