# frozen_string_literal: true

require_relative 'questions_db'

class Questions
  attr_accessor :id, :title, :body, :author_id

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM questions')
    data.map { |datum| Questions.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    data.map { |datum| Questions.new(datum) }
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDB.instance.execute(<<-SQL, author_id)
      SELECT
        * 
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    data.map { |datum| Questions.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end
end
