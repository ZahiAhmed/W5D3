# frozen_string_literal: true

require_relative 'questions_db'

class QuestionFollows
  attr_accessor :id, :user_id, :question_id

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM question_follows')
    data.map { |datum| QuestionFollows.new(datum) }
  end

  def self.find_by_id(arg_id)
    data = QuestionsDB.instance.execute(<<-SQL, arg_id)
          SELECT
            *
          FROM
            question_follows
          WHERE
            id = ?#{' '}
    SQL

    data.map { |datum| QuestionFollows.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
