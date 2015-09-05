require 'rails_helper'

feature 'endorsing reviews' do
  before {Restaurant.create name: 'KFC'}
  before do

#     kfc = Restaurant.create(name: 'KFC')
#     kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
#   end
#
#   it 'a user can endorse a review, which increments the endorsement count', js: true do
#     visit '/restaurants'
#     click_link 'Endorse'
#     expect(page).to have_content("1 endorsement")
#   end
# end

    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    leave_review('Great', '5')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 endorsement')
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

end
