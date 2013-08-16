class Question
  attr_reader :question, :answer

  def initialize(args)
    @question = args[0]
    @answer   = args[1]
  end

  def to_s
    "#{question} - #{answer}"
  end

  def correct_answer(string)
    true if string == answer
  end
end

class QuestionParser
  attr_reader :file, :list
  
  def initialize(file = 'flashcard_samples.txt')
    @file = file
    @list = List.new
  end

  def execute
    array = pair_question(load)
    create_objects(array)
    list.all_questions
  end

  private

  def load
    array = []
    File.open(file).each do |line|
      array << line.chomp
    end
    array
  end

  def pair_question(array)
    new_array = []
    array.reject! { |i| i == "" }
    i = 0
    (array.length / 2).times do
      new_array << [array[i], array[i+1]]
      i+=2
    end
    new_array
  end

  def create_objects(array)
    array.each do |pair|
      list.add(Question.new(pair))
    end

  end

end

class List
  attr_reader :all_questions

  def initialize
    @all_questions = []
  end

  def add(question_object)
    @all_questions << question_object
  end
end




# parser = QuestionParser.new

# puts parser.execute
