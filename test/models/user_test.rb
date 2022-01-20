require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without name" do
    user = User.new
    assert_not user.save, "Saved the user without a name"
  end

  test "should not save user without password" do
    user = User.new(name: "name", password: nil)
    assert_not user.save, "Saved the user without a password"
  end

  test "password invalid if it is greater than 16" do
    password = User.new(name: 'name', password: '01234567891234567')
    assert_not password.valid?
  end

  test "password invalid if it is password less than 10" do
    password = User.new(name: 'name', password: '012345678')
    assert_not password.valid?
  end

  test "password invalid if it does not contain an uppercase" do
    password = User.new(name: 'name', password: 'abcdefghijklmnop')
    assert_not password.valid?
  end

  test "password invalid if it does not contain a digit" do
    password = User.new(name: 'name', password: 'abcdefghijklmnop')
    assert_not password.valid?
  end

  test "password invalid if it contains three repeating characters (eg: AAA)" do
    password = User.new(name: 'name', password: 'AAAfk1swods')
    assert_not password.valid?
  end

  test "password valid if it has at least 10 characters and at most 16 characters, 
  it contains at least one lowercase character, one uppercase character and one digit,
  It doesnt contain three repeating characters in a row" do
    password = User.new(name: 'name', password: 'Aqpfk1swods')
    assert password.valid?
  end
end
