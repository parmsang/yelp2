require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('So so', '3')
    click_link 'Sign out'
    click_link('Sign up')
    fill_in('Email', with: 'test2@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end

  scenario 'a user can only review a restaurant once' do
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review KFC'

    expect(page).to have_content 'You have already reviewed this restaurant'
    expect(page).not_to have_content 'Meh'
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

end
