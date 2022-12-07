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

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @subj = options['subj']
    @user_id = options['user_id']
    @parent_reply_id = options['parent_reply_id']
  end
end
