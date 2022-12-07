# frozen_string_literal: true

require_relative 'questions_db'

class Replies
  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM replies')
    data.map { |datum| Replies.new(datum) }
  end

  def self.find_by_id(arg_id)
    data = QuestionsDB.instance.execute(<<-SQL, arg_id)
        SELECT
            *
        FROM
            replies
        WHERE
            id = ?#{' '}
    SQL
    data.map { |datum| Replies.new(datum) }
  end

  def self.find_user_id(user_id)
    data = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM 
        replies
      WHERE
        user_id = ?
    SQL

    data.map { |datum| Replies.new(datum)}
  end


  def self.find_by_question_id(question_id)
    data = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM 
        replies
      WHERE
        subj = ?
    SQL

    data.map { |datum| Replies.new(datum)}
  end


  def initialize(options)
    @id = options['id']
    @body = options['body']
    @subj = options['subj']
    @user_id = options['user_id']
    @parent_reply_id = options['parent_reply_id']
  end

  def author
    Users.find_by_id(@user_id)
  end

  def question 
    Questions.find_by_id(@subj)
  end

  def parent_reply
    Replies.find_by_id(@parent_reply_id)
  end

  def child_replies
    data = QuestionsDB.instance.execute(<<-SQL @id)
    SELECT
        *
    FROM
        replies
    WHERE
        parent_reply_id = ?
    SQL

    data.map {|datum| Replies.new(datum)}
  end
end
