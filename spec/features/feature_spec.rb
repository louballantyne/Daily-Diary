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
    expect(page).to have_text "Lambs"
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
    expect(page).to have_text('Baking!')
  end
end

feature 'View an entry' do
  before do
    add_entries
    visit '/'
  end
  scenario "Users clicks on the title of the entry they wish to view, then views the entry" do
    click_on('Lambs!')
    expect(page).to have_text('Becky')
  end
end

feature 'Update an entry' do
  before do
    add_entries
    visit '/'
  end
  scenario "User clicks update for the first entry and changes the number of lambs Becky delivered from 3 to 2" do
    first('.entry').click_button('Update')
    fill_in('entry', :with => 'Becky had lambs. She delivered 2 healthy lambs even though we did not know she was pregnant.')
    click_on('Update')
    click_on('Lambs!')
    expect(page).to have_text 'delivered 2 healthy lambs'
  end
end

feature 'Add a comment' do
  before do
    add_entries
    visit '/'
  end
  scenario "User comments on first entry" do
    first('.entry').click_button('Comment')
    fill_in('comment', :with => 'They are so cute!')
    click_on('Add')
    click_on('Lambs!')
    expect(page).to have_text 'They are so cute!'
  end
end

feature 'Add a tag' do
  before do
    add_entries
    visit '/'
  end
  scenario "User tags an entry with #animals" do
    first('.entry').click_button('Tag')
    fill_in('tag', :with => '#animals')
    click_on('Add')
    expect(page).to have_text '#animals'
  end
  scenario 'User retrieves a list of entries with the tag #animals' do
    first('.entry').click_button('Tag')
    fill_in('tag', :with => '#animals')
    click_on('Add')
    fill_in('search_tag', :with => '#animals')
    click_on('search_by_tag')
    expect(page).to have_text 'Becky'
  end
end
