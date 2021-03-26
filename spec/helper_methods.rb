require 'pg'

def check_env
  ENV['TESTING'] == 'true' ? @dbname = 'diary_manager_test' : @dbname = 'diary_manager'
end

def clear_table
  check_env
  conn = PG.connect( dbname: @dbname )
  conn.exec( "TRUNCATE TABLE entries CASCADE; " )
  conn.exec( "TRUNCATE TABLE comments; " )
  conn.close if conn
end

def add_entries
  check_env
  conn = PG.connect( dbname: @dbname )
  conn.exec( "INSERT INTO entries (date, title, entry, id) VALUES ('2021-03-25', 'Lambs!', 'Becky had lambs. She delivered 3 healthy lambs even though we did not know she was pregnant.', '1')" )
  conn.exec( "INSERT INTO entries (date, title, entry, id) VALUES ('2021-01-03', 'Birthday!', 'My birthday! I baked a cake and had some Mac and Cheese. Claire came over. It was nice to see her.', '2')" )
  conn.exec( "INSERT INTO entries (date, title, entry, id) VALUES ('2021-02-01', 'My course', 'It is the start of my course. It is just the precourse so I am not working full time yet.', '3')"  )
  conn.close if conn
end
