require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end
  test "unsuccessfull edit " do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template  'users/edit'
    patch user_path(@user),params:{user:{name:"",
                                         password:"foo",
                                         email:"foo@invalid",
                                         password_confirmation:"bar"}}
    assert_template 'users/edit'
    assert_select  'div.alert','The form contains 3 errors'
  end
  test "succesfull edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name="Foo Bar"
    email="foo@bar.com"
    patch user_path(@user),params:{user:{name:name,email:email,password:"password",password_confirmation:"password"}}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,@user.name
    assert_equal email,@user.email
  end
end
