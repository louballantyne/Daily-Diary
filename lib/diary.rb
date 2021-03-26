require 'pg'
require_relative 'comments'
require_relative 'tags'

class Diary
  attr_accessor :entry, :id, :date, :title

  def self.check_env
    ENV['TESTING'] == 'true' ? @dbname = 'diary_manager_test' : @dbname = 'diary_manager'
  end

  def self.all
    @diary_entries = []
    Diary.check_env
    conn = PG.connect( dbname: @dbname )
    conn.exec( "SELECT * FROM entries").map do |entry|
      @diary_entries << Diary.new(entry['id'], entry['date'], entry['title'], entry['entry'])
    end
    conn.close if conn
    return @diary_entries
  end

  def initialize(id, date, title, entry)
    @id = id
    @date = date
    @entry = entry
    @title = title
  end

  def self.delete(id)
    Diary.check_env
    conn = PG.connect( dbname: @dbname )
    conn.exec( "DELETE FROM entries WHERE id=#{id}")
    conn.close if conn
  end

  def self.add(date, title, entry)
    Diary.check_env
    conn = PG.connect( dbname: @dbname )
    conn.exec( "INSERT INTO entries (date, title, entry) VALUES ('#{date}', '#{title}', '#{entry}')")
    conn.close if conn
  end

  def self.view_entry(id)
    @diary_entries.each do |entry|
      return entry.entry if entry.id == id
    end
  end

  def self.find(id)
    @diary_entries.each do |entry|
      return entry if entry.id == id
    end
  end

  def self.update(id, date, title, entry)
    conn = PG.connect(dbname: @dbname)
    result = conn.exec("UPDATE entries SET title='#{title}', date='#{date}', entry='#{entry}' WHERE id = '#{id}';")
  end

  def self.comment(entry_id, comment)
    conn = PG.connect( dbname: @dbname )
    conn.exec( "INSERT INTO comments (entry_id, comment) VALUES ('#{entry_id}', '#{comment}')")
  end

  def self.show_comments(entry_id)
    @comment_class = Comment
    @comments = []
    Diary.check_env
    conn = PG.connect( dbname: @dbname )
    conn.exec( "SELECT comment FROM comments LEFT JOIN entries ON comments.entry_id = entries.id WHERE entries.id = #{entry_id}").map do |comment|
      @comments << @comment_class.new(comment['id'], comment['comment'])
    end
    return @comments
  end

  def self.tag(entry_id, tag)
    conn = PG.connect( dbname: @dbname )
    conn.exec( "INSERT INTO tags (entry_id, tag) VALUES ('#{entry_id}', '#{tag}')")
  end

  def self.show_tags(entry_id)
    @tag_class = Tags
    @tags = []
    Diary.check_env
    conn = PG.connect( dbname: @dbname )
    conn.exec( "SELECT tag FROM tags WHERE entry_id = '#{entry_id}'").map do |tag|
      @tags << @tag_class.new(tag['tag'], tag['entry_id'], tag['id'])
    end
    return @tags
  end

  def self.tagged_entries(tag)
    @tagged_entries = []
    Diary.check_env
    conn = PG.connect( dbname: @dbname )
    conn.exec( "SELECT entry, title, date, entries.id FROM entries INNER JOIN tags ON entries.id = tags.entry_id WHERE tags.tag = '#{tag}'").map do |entry|
      @tagged_entries << entry
    end
    return @tagged_entries
  end
end
