require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As a Public User', type: :feature do

  describe 'browsing' do
    it 'can click on a category and see items' do
      visit '/'
      click_on("men")
      click_on("Mens Pants")
      expect(page).to have_content("Mens Pants")
    end

    it 'can click on a business name and see store page' do
      visit '/'
      within("#stores-dropdown") do
        first(:link).click
      end
      expect(page).to have_css("#store-name")
    end

    it 'can click on an item and see item page' do
      visit '/'
      click_on("men")
      click_on("Mens")
      first_item = first(:css, '.grid-item')
      within(first_item) do
        first(:link).click
      end
      expect(page).to have_css("#item-show-page")
    end

  end

  describe 'cart interaction', type: :feature do
    it 'can add items to a shopping cart' do
      visit '/'
      click_on("men")
      click_on("Mens")
      first_item = first(:css, '.grid-item')
      within(first_item) do
        first(:link).click
      end
      click_on("add to cart")
      expect(page).to have_content("1 item")
    end

    it 'maintains a shared shopping cart across all businesses I browse' do
      visit '/'
      click_on("men")
      click_on("Mens")
      first_item = first(:css, '.grid-item')
      within(first_item) do
        first(:link).click
      end
      click_on("add to cart")
      expect(page).to have_content("1 item")
      click_on("Women")
      click_on("Womens Dresses")
      first_item = first(:css, '.grid-item')
      within(first_item) do
        first(:link).click
      end
      click_on("add to cart")
      expect(page).to have_content("2 items")
    end

    it 'must log in before completing checkout' do
      visit '/'
      click_on("men")
      click_on("Mens")
      first_item = first(:css, '.grid-item')
      within(first_item) do
        first(:link).click
      end
      click_on("add to cart")
      click_on("cart-bttn")
      click_on("delivery_btn")
      expect(page).to have_content("Please log in or create account to complete order")
    end

    it 'after logging in, I immediately resume the checkout process' do
      visit '/'
      click_on("men")
      click_on("Mens")
      first_item = first(:css, '.grid-item')
      within(first_item) do
        first(:link).click
      end
      click_on("add to cart")
      click_on("cart-bttn")
      click_on("Complete Order")
      expect(page).to have_content("Please log in or create account to complete order")
      fill_in "email_address", with: "demo+rachel@jumpstartlab.com"
      fill_in "password", with: "password"
      click_on("Sign in")
      click_on("delivery_btn")
      expect(page).to have_content("Address")
    end

  end

  describe 'creating/managing an account' do
    it 'can create an account' do
      visit '/'
      click_on("Sign Up")
      fill_in "user_full_name", with: "Test User"
      fill_in "user_email_address", with: "testuser@example.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_on("Create User")
      expect(page).to have_content("You Have Successfully Created A New Account!")
    end

    it 'expects to receive a welcome email after creating account'

    it 'can request that my account become a business owner' do
      visit '/'
      click_on("Sign Up")
      fill_in "user_full_name", with: "Test User"
      fill_in "user_email_address", with: "testuser@example.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_on("Create User")
      fill_in "email_address", with: "testuser@example.com"
      fill_in "password", with: "password"
      click_on("Sign in")
      click_on("Open a Dope Store")
      expect(page).to have_content("Store Request")
    end
  end

end
