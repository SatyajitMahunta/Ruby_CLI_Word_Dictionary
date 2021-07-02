def extract_content(uri)
  content = Net::HTTP.get uri
  data = JSON.parse(content)
  return data
end  

def word_definition(word)
  link = URI "https://fourtytwowords.herokuapp.com/word/#{word}/definitions?api_key=" + API_KEY
  # Extract the data
  data = extract_content(link)
  # Iterate through the hash
  x = 1
  data.each do |child|
    puts "DEFINITION #{x.to_s} :  "
    puts child["text"]
    puts "\n" 
    x = x + 1  
  end
end
  
def word_related(word,type)
  link = URI "https://fourtytwowords.herokuapp.com/word/#{word}/relatedWords?api_key=" + API_KEY
  # Extract the data
  data = extract_content(link)
  # Iterate through the hash
  if data[0]["relationshipType"] != type && type != nil
    puts "Sorry, #{type} for word #{word} is not found :( \n"
    return
  end  

  x = 1
  puts "RelationShip Type : " + data[0]["relationshipType"] + " \n";
  data.each do |child|
    puts child["words"]
  end
end

def word_examples(word)
  link = URI "https://fourtytwowords.herokuapp.com/word/#{word}/examples?api_key=" + API_KEY
  # Extract the data
  data = extract_content(link)
  # Iterate through the hash
  x = 1
  data["examples"].each do |child|
    puts "EXAMPLE #{x.to_s} :  "
    puts child['text']
    puts "\n" 
    x = x + 1  
  end
end

def word_full_dict(word)
  word_definition(word)
  word_related(word,nil)
  word_examples(word)
end

def word_of_the_day
  link = URI 'https://fourtytwowords.herokuapp.com/words/randomWord?api_key=' + API_KEY
  
  data = extract_content(link)
  # Declare the variables
  word = data['word']
  # Display the result
  puts "[  WORD OF THE DAY  ]   :  " + "#{word}\n"
  word_full_dict(word)
end
