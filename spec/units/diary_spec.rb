require_relative '../../lib/diary'
require_relative "../helper_methods"

describe Diary do
  before do
    add_entries
  end
  it 'returns all diary entries' do
    expect(Diary.all.first).to be_an_instance_of(Diary)
  end
  it 'deletes a selected entry' do
    length = Diary.all.length
    Diary.delete(Diary.all.first.id)
    expect(Diary.all.length).to eq length-1
  end
  it 'adds an entry' do
    length = Diary.all.length
    Diary.add('2021-03-02','I love parrots','parrots')
    expect(Diary.all.length).to eq length+1
  end
  it 'creates an entry that responds to title' do
    expect(Diary.all.first).to respond_to(:title)
  end
  it 'creates an entry that returns the given title' do
    expect(Diary.find('3').title).to eq 'My course'
  end
  it 'creates an entry that responds to id' do
    expect(Diary.all.first).to respond_to(:id)
  end
  it 'creates an entry that responds to entry' do
    expect(Diary.all.first).to respond_to(:entry)
  end
  it 'creates an entry that returns the given entry' do
    expect(Diary.find('3').entry).to eq 'It is the start of my course. It is just the precourse so I am not working full time yet.'
  end
  it 'finds the correct entry given the id' do
    expect(Diary.find('3').id).to eq '3'
  end
  it 'View entry returns the given entry' do
    expect(Diary.view_entry('2')).to eq 'My birthday! I baked a cake and had some Mac and Cheese. Claire came over. It was nice to see her.'
  end
  it 'Updates a given entry' do
    Diary.update('1', '2021-03-25', "Beckys Lambs!", 'Becky had lambs. She delivered 3 healthy lambs even though we did not know she was pregnant.')
    Diary.all
    expect(Diary.find('1').title).to eq "Beckys Lambs!"
  end
  it "Adds a comment to a given entry and retrieves it " do
    Diary.comment('1',"They are super cute!")
    expect(Diary.show_comments('1').first.comment).to eq "They are super cute!"
  end
  it "Adds a tag to a given entry and retrieves it" do
    Diary.tag('1','#animals')
    expect(Diary.show_tags('1').first.tag).to eq "#animals"
  end
  it 'returns a list of diary entries with a given tag' do
    Diary.tag('1','#animals')
    Diary.tag('2','#animals')
    expect(Diary.tagged_entries('#animals').length).to eq 2
  end

end
