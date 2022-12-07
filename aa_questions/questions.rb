require 'questions_db'
class Questions

  attr_accessor :id, :title, :body, :author_id

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM questions')
    data.map { |datum| Questions.new(datum) }
  end

  def self.find_by_id(arg_id)
    QuestionsDB.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
      WHERE
        id = #{arg_id} 
    SQL
  end

  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @author_id = options["author_id"]
  end
end
