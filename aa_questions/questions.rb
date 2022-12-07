require 'sqlite3'
require 'singleton'

class QuestionsDB < SQLite3::Database
  include Singleton

  def initialize
    super('questions.rb')
    self.type_translation = true
    self.results_as_hash = true
  end

end

class Questions

  attr_accessor :id, :title, :body, :author_id

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM questions')
    data.map { |datum| Questions.new(datum) }
  end

  def self.find_by_id(id)
  end

  

end
