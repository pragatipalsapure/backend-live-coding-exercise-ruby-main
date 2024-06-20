# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise

## approach

The survey program is structured with modular methods, each dedicated to a specific task such as querying users, computing ratings, and presenting outcomes.

The do_prompt method engages users by posing survey inquiries and logging their replies in a PStore.

In the calculate_rating method, the rating for a session is computed based on the count of "yes" responses provided by the user.

The do_report method computes and communicates the average rating across all sessions, leveraging data retained in the PStore.

Incorporating error handling guarantees that users input valid responses.

Furthermore, comments are included within the code to elucidate the purpose of each segment.


## Usage

```sh
bundle
ruby questionnaire.rb

rspec questionnaire_spec.rb


