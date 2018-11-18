require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "password_reset" do
    user = users(:brett)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "MISI Password Reset Instructions", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@misi.info"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end

end
