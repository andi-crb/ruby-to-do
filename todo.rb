module Menu
  def menu
    "Welcome! This is a to do list! Please pick from one of the below options:
    1) Add
    2) Show
    3) Write to a file
    4) Read from a file
    5) Delete
    6) Update
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
    all_tasks.map.with_index { |l, i| "(#{i.next}): #{1}"}
  end
  def write_to_file(filename)
    IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
  end
  def read_from_file(filename)
    IO.readlines(filename).each do |line|
      add(Task.new(line.chomp))
    end
  end
  def delete(index)
    all_tasks.delete_at(index - 1)
  end
  def update(index, value)
    all_tasks(index-1) = value
  end
end

class Task
  attr_reader :description
  def initialize(description)
    @description = description
  end
  def to_s
    description
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
        when '3'
          my_list.write_to_file(prompt('What is the filename to write to?'))
        when '4'
          begin
            my_list.read_from_file(prompt('What is the filename to read from?'))
          rescue Errno::ENOENT
              puts 'File name not found, please verify your file name and path.'
            end
        when '5'
          puts my_list.show
          my_list.delete(prompt('Enter the number of the task you wish to delete').to_i)
        when '6'
          my_list.update(prompt('Which task do you want to modify').to_i, Task.new(prompt('Enter the update task info')))
        else
          puts "Sorry, I don't understand that option."
      end
      prompt('Press enter to continue', '')
    end
  puts 'Outro - Thanks for using the menu system!'
end
