require "pstore"  # https://github.com/ruby/pstore
STORE_NAME = "tendable.pstore"

store = PStore.new(STORE_NAME)
store.transaction do
  store[:answers] ||= {}
end

# Questions for the survey
QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

# Prompt the user to answer the questions
def do_prompt(store)
  # Initialize count for yes answers
  yes_count = 0

  # Define valid user input
  users_input = ['yes', 'no', 'y', 'n']

  # Ask each question and record the response
  QUESTIONS.each_key do |question_key|
    print "#{QUESTIONS[question_key]} (Yes/No or Y/N): "
    answer = gets.chomp.downcase

    if users_input.include?(answer)
      # To store the user's response
      store.transaction do
        store[:answers][question_key] = answer
      end
      yes_count += 1 if ['yes', 'y'].include?(answer)
      rating = calculate_rating(yes_count)
      report_rating(rating)
    else
      puts "Invalid input. Please answer with Yes/No or Y/N."
    end
  end

  yes_count
end

# to calculate the rating for the current run
def calculate_rating(yes_count)
  # Total number of questions
  total_questions = QUESTIONS.size
  # Calculate the rating as the percentage of 'yes' answers
  return 0 if total_questions.zero? # Avoid division by zero
  (yes_count.to_f / total_questions) * 100
end

# to report the rating for the current run
def report_rating(rating)
  puts "Your rating for this run: #{rating.round(2)}%"
end

# to calculate and report the average rating for all runs
def do_report(store, yes_count)
  total_runs = store.transaction { store[:answers].length }   # Total number of runs
  # Total number of 'yes' answers across all runs
  total_yes_count = store.transaction { store[:answers].values.count { |ans| ['yes', 'y'].include?(ans) } }

  # Calculate the average rating
  average_rating = 100 * (total_yes_count.to_f / (QUESTIONS.length * total_runs))
  puts "Average rating for all runs: #{average_rating.round(2)}%"
end

survey_running = true
while survey_running
  puts "Starting new run......"
  # Prompt the user to answer the questions
  yes_count = do_prompt(store) 
  # Calculate and report the average rating for all runs
  do_report(store, yes_count)

  # Prompt the user to continue or exit
  print "Do you want to continue? (Yes/No): "
  continue = gets.chomp.downcase
  break unless ['yes', 'y'].include?(continue)
end