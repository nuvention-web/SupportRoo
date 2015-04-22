require 'capybara/rails'
require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include(FactoryGirl::Syntax::Methods)
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def sign_in_with_form(user)
    visit('/users/sign_in')

    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_button('Log in')
  end
end
