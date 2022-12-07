PRAGMA foreign_keys = ON;

CREATE TABLE  users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL, -- TODO: Do we need NOT NULL?
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY, -- TODO: DO we need it 
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  subj INTEGER NOT NULL,
  user_id INTEGER,
  parent_reply_id INTEGER,

  FOREIGN KEY (subj) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO 
  users(fname, lname)
VALUES
  ('Ned', 'Ned LastName'),
  ('KUS', 'KUS LastName'),
  ('Earl', 'Earl LastName');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('Ned Questions', 'NED NED NED', 1),
  ('KUS Questions', 'KUSH KUSH K', 2),
  ('Ear Questions', 'MEOW MEOW M', 3);
