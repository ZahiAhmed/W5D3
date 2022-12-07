# frozen_string_literal: true

require_relative 'questions_db'

class QuestionLikes
  attr_accessor :id, :user_id, :question_id

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM question_likes')
    data.map { |datum| QuestionLikes.new(datum) }
  end

  def self.find_by_id(arg_id)
    data = QuestionsDB.instance.execute(<<-SQL, arg_id)
        SELECT
            *
        FROM
            question_likes
        WHERE
            id = ?#{' '}
    SQL

    data.map { |datum| QuestionLikes.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
