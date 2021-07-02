require 'net/http'
require 'json'
require_relative 'word_methods'
require_relative 'word_game'
require_relative 'credentials'


def check_isPresent_or_not(word)
    if word == nil
        puts "Please write the word, after the type of operation."
        return false
    end 
    # Checking the word is present or not, in the Dictionary.  
    link = URI "https://fourtytwowords.herokuapp.com/word/#{word}/definitions?api_key=" + API_KEY
    # Extract the data
    data = extract_content(link)
    if !data.instance_of?Array
      puts "WORD IS NOT PRESENT IN THE DICTIONARY :( \n\n" 
      return false
    end
    return true  
end
  
operation_type = ARGV[0]
puts Fetch_data
case operation_type
  when nil
    puts "WORD OF THE DAY :"
    word_of_the_day
  when "def"
    if check_isPresent_or_not(ARGV[1])
        puts "Definitions of word  :: " + ARGV[1] + " ::\n"
        word_definition(ARGV[1])
    end    
  when "syn"
    if check_isPresent_or_not(ARGV[1])
        puts "Synonym of word  :: " + ARGV[1] + " ::\n"
        word_related(ARGV[1],"synonym")
    end
  when "ant"
    if check_isPresent_or_not(ARGV[1])
        puts "Antonym of word  :: " + ARGV[1] + " ::\n"
        word_related(ARGV[1],"antonym")
    end
  when "ex"
    if check_isPresent_or_not(ARGV[1])
        puts "Examples of word  :: " + ARGV[1] + " ::\n"
        word_examples(ARGV[1])
    end
  when "play"
     ARGV.clear()
     puts "Game Scoring :: ʕ•ᴥ•ʔcl
      Each correct answer gives 10 points.
      Each hint reduces 3 point.
      Each wrong try reduces 2 points.
      Skip reduces 4 points.
      "
      puts "\nGAME LOADING......[PLEASE WAIT]\n\n"
      word_game  
  else
    if check_isPresent_or_not(ARGV[0])
        puts "Full Details of word  :: " + ARGV[0] + " ::\n"
        word_full_dict(ARGV[0])
    end      
end               