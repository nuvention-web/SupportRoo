require 'test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  test "flash helper should output correct things" do
    assert_equal flash_helper('notice'), 'success'
    assert_equal flash_helper('warning'), 'warning'
    assert_equal flash_helper('error'), 'alert'
    assert_equal flash_helper('foobar'), 'alert'
  end

end