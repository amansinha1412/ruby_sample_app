require 'test_helper'

class SessionsHelperTest<ActionView::TestCase
  def setup
    @user = users(:michael)
  end

  test "current user return the right user" do
    assert_equal @user,current_user
    # assert is_logged_in?
  end

  test "current user returns nil when remember_digest is wrong" do
    @user.update_attribute(:remember_digest,User.digest(User.new_token))
    assert_nil current_user
  end
end
