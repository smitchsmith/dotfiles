CREATE TABLE users (

  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (

  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (

  id INTEGER PRIMARY KEY,

  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (

  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)

);

CREATE TABLE question_likes (

  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO
  users (fname, lname)
VALUES
  ('mitch', 'smith'), ('alex', 'harris');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('How to SQL?', 'I cant SQL', (SELECT id FROM users WHERE fname = 'mitch')),
  ('Is madonna still a thing?', 'Whos madonna?', (SELECT id FROM users WHERE fname = 'alex'));


INSERT INTO
  question_followers (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'mitch'), (SELECT id FROM questions WHERE title = 'How to SQL?')),
  ((SELECT id FROM users WHERE fname = 'mitch'), (SELECT id FROM questions WHERE title = 'Is madonna still a thing?')) ,
  ((SELECT id FROM users WHERE fname = 'alex'), (SELECT id FROM questions WHERE title = 'How to SQL?'));

INSERT INTO
  replies (question_id, reply_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'How to SQL?'), NULL,
  (SELECT id FROM users WHERE fname = 'alex'), ('SQL is a myth. It doesnt exist')),

  ((SELECT id FROM questions WHERE title = 'How to SQL?'), (SELECT id FROM replies WHERE body = 'SQL is a myth. It doesnt exist'),
  (SELECT id FROM users WHERE fname = 'mitch'), ('SQL is cool bro.'));

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'alex'), (SELECT id FROM questions WHERE title = 'How to SQL?')),
  ((SELECT id FROM users WHERE fname = 'mitch'), (SELECT id FROM questions WHERE title = 'Is madonna still a thing?'));