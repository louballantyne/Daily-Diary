require 'pg'

class Diary
  attr_accessor :entry, :id, :date

  def self.check_env
    ENV['TESTING'] == 'true' ? @dbname = 'diary_manager_test' : @dbname = 'diary_manager'
  end

  def self.all
    @diary_entries = []
    Diary.check_env
    conn = PG.connect( dbname: @dbname )
    conn.exec( "SELECT * FROM entries").map do |entry|
      @diary_entries << Diary.new(entry['id'], entry['date'], entry['entry'])
    end
    conn.close if conn
    return @diary_entries
  end

  def initialize(id,date,entry)
    @id = id
    @date = date
    @entry = entry
  end

  def self.delete(id)
    Diary.check_env
    conn = PG.connect( dbname: @dbname )
    conn.exec( "DELETE FROM entries WHERE id=#{id}")
    conn.close if conn
  end

  def self.add(date,entry)
    Diary.check_env
    conn = PG.connect( dbname: @dbname )
    conn.exec( "INSERT INTO entries (date, entry) VALUES ('#{date}', '#{entry}')")
    conn.close if conn
  end
end
