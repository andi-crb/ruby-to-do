module Menu
  def menu
    "Welcome! This is a to do list! Please pick from one of the below options:
    1) Add
    2) Show
    Q) Quit"
  end
  def show
    menu
  end
end

module Promptable
  def prompt(message = 'What would you like to do?', symbol = ':> ')
    print message
    print symbol
    gets.chomp
  end
end

class List
  attr_reader :all_tasks
  def initialize
    @all_tasks = []
  end
  def add(task)
    all_tasks << task
  end
  def show
    all_tasks
  end
end

class Task
  attr_reader :description
  def initialize(description)
    @description = description
  end
end

if __FILE__ == $PROGRAM_NAME
  include Menu
  include Promptable
  my_list = List.new
    until ['q'].include?(user_input = prompt(show).downcase)
      case user_input
        when '1'
          my_list.add(Task.new(prompt('What is the task you would like to add?')))
        when '2'
          puts my_list.show
        else
          puts "Sorry, I don't understand that option."
      end
      prompt('Press enter to continue', '')
    end
  puts 'Outro - Thanks for using the menu system!'
end
