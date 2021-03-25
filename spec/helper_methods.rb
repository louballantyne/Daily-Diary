require 'pg'

def check_env
  ENV['TESTING'] == 'true' ? @dbname = 'diary_manager_test' : @dbname = 'diary_manager'
end

def clear_table
  check_env
  conn = PG.connect( dbname: @dbname )
  conn.exec( "TRUNCATE TABLE entries" )
  conn.close if conn
end

def add_entries
  check_env
  conn = PG.connect( dbname: @dbname )
  conn.exec( "INSERT INTO entries (date, entry) VALUES ('2021-03-25', 'Becky had lambs')" )
  conn.exec( "INSERT INTO entries (date, entry) VALUES ('2021-01-04', 'My birthday!')" )
  conn.exec( "INSERT INTO entries (date, entry) VALUES ('2021-02-01', 'Start of my course')"  )
  conn.close if conn
end
