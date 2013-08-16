# Main file for 
require "./flashcard_model.rb"
class Controller
 attr_reader :list
  def initialize(list = List.new)
    @list = list
  end

  def run_controller
    move_to_home!
    clear_screen!
    puts "Welcome to Flashcards"
    puts "Instructions: try to guess the answer or type QUIT to quit"
    execute(list)
  end

 private
  def execute(list_questions)
  # Recives an array of question objects
    list_questions.each do |object|
      input = display_question(object)
      return "Goodbye" if input == "QUIT" 
      puts  validate_answer(object,input)
      sleep(1)
      move_to_home!
      clear_screen!
    end
    puts "The game gitis over"
  end


  def display_question(question_obj)
    puts question_obj.question
    answer = gets.chomp
  end

  def validate_answer(question,input)
    if question.correct_answer(input) == true
      return "Correct" 
    else
      "Incorrect"
    end
  end

  def clear_screen!
    print "\e[2J"
  end
  
  def move_to_home!
    print "\e[H"
  end

end


parser = QuestionParser.new
list = parser.execute
# puts list

# question = Question.new(["This is a question", "yes"])

controller = Controller.new(list)
# answer = controller.display_question(question)
# puts controller.validate_answer(question,answer)
controller.run_controller
