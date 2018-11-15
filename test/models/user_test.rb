require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name:"Example  User",email:"User@example.com" ,password:"foobar",password_confirmation:"foobar")
  end
  test "should be valid" do
    assert @user.valid?
  end
  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end
  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end
  test "name should not be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end
  test 'email should not be too long' do
    @user.email = 'a' *255 + 'example.com'
    assert_not @user.valid?
  end
  test 'email address should be valid' do
    valid_addresses = %w[ser@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?,"#{valid_address} is a valid address"
    end
  end
  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  test "email adddress should be saved as lower-case" do
    mixed_case_mail = "Foo@Example.com"
    @user.email = mixed_case_mail
    @user.save
    assert_equal mixed_case_mail.downcase ,@user.reload.email
  end
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " "*5
    assert @user.password.blank?
  end
  test "passowrd must have minimum length" do
    @user.password = @user.password_confirmation = "a"*5
    assert_not @user.valid?
  end
end
