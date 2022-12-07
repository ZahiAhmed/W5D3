# frozen_string_literal: true

require_relative 'questions_db'

class Users
  attr_accessor :id, :fname, :lname

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM users;')
    data.map { |datum| Users.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    data.map { |datum| Users.new(datum) }
  end

  def self.find_by_name(fname, lname)
    user_data = QuestionsDB.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    user_data.map { |datum| Users.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  # questions parameter represents Array of questions instances
  def authored_questions
    Questions.find_by_author_id(@id)
  end

  def authored_replied
    Replies.find_by_user_id(@id)
  end
end
