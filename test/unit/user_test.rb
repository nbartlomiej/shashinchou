require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "shouldn't allow invalid email" do
    assert !User.new(:email => "invalid_email", :password => "password").save
  end

  test "email should be required" do
    assert !User.new(:password => "password").save
  end

  test "password should be required" do
    assert !User.new(:email => "valid@email.com").save
  end

  test "email should be unique" do
    assert User.new(:email => "valid@email.com", :password => "first_password").save
    assert !User.new(:email => "valid@email.com", :password => "second_password").save
  end

  # somebody might overenthusiastically set the
  # password to unique; while not catastrophical,
  # we don't want that
  test "password shouldn't be unique" do
    assert User.new(:email => "valid@email_1.com", :password => "password").save
    assert User.new(:email => "valid@email_2.com", :password => "password").save
  end


  test "password should be of adequate length" do
    assert !User.new(:email => "valid@email_1.com", :password => "12345").save # <6 characters, too short
    assert !User.new(:email => "valid@email_2.com", :password => "1"*25 ).save # >24 characters, too long
    assert User.new(:email => "valid@email_3.com", :password => "123456").save # 4 characters is ok
    assert User.new(:email => "valid@email_4.com", :password => "1"*24 ).save  # 24 chars is ok
  end


end
