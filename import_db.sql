CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL, -- TODO: Do we need NOT NULL?
  lname VARCHAR(255) NOT NULL
)

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
)

CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY, -- TODO: DO we need it 
)