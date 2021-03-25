require_relative "../../app"
require_relative "../helper_methods"

feature 'Homepage' do
  before do
    add_entries
    visit '/'
  end
  scenario 'User navigates to homepage and sees title' do
    expect(page).to have_text 'Diary Entries'
  end
end

feature 'View entries' do
  before do
    add_entries
    visit '/'
  end
  scenario 'User views diary entries' do
    expect(page).to have_text '2021-03-25'
    expect(page).to have_text 'Becky had lambs'
  end
end

feature 'Delete an entry' do
  before do
    add_entries
    visit '/'
  end
  scenario "User deletes the first diary entry" do
    first('.entry').click_button 'Delete'
    expect(page).to have_text 'Diary'
    expect(page).not_to have_text 'Becky'
  end
end

feature 'Add an entry' do
  scenario "User adds an entry 'I baked a cake today' to the diary" do
    visit '/'
    click_on('new_entry')
    fill_in('date', :with => '2021-03-24')
    fill_in('entry', :with => 'I baked a cake today')
    fill_in('title', :with => 'Baking!')
    click_on('Add')
    expect(page).to have_text('I baked a cake today')
  end
end
