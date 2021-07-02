require_relative 'word_methods'

def isRelated_Word(word,word_arr)
    if word_arr.include?word
        return true
    end 
    return false    
end    

def word_game
    random_word = ''
    score = 0
    word_def_cnt = 0
    related_word_cnt = 0
    word_def_len = 0
    related_word_len = 0
    data_def = ''
    data_syn_ant = ''
    code = 2
    flag = rand(0..1)
    while true
        if code == 1  # 1 -- > SKIP 
            puts "The Word is ::  "
            puts random_word + "\n"
            word_full_dict(random_word)
            code = 2
        end 
        if code == 2  # Initialize new word and update neccessary data
            link = URI 'https://fourtytwowords.herokuapp.com/words/randomWord?api_key=' + API_KEY
            data = extract_content(link)
            random_word = data['word']
            link1 = URI "https://fourtytwowords.herokuapp.com/word/#{random_word}/definitions?api_key=" + API_KEY
            # Extract the data
            data_def = extract_content(link1)
    
            link2 = URI "https://fourtytwowords.herokuapp.com/word/#{random_word}/relatedWords?api_key=" + API_KEY
            # Extract the data
            data_syn_ant = extract_content(link2)
            related_word_arr = data_syn_ant[0]["words"]
        
            #puts related_word_arr
            word_def_len = data_def.length()
            related_word_len = related_word_arr.length()
            puts "New Random Word Initialized, Now Guess it :)\n" 
            puts  "[ THIS WORD IS PRINTED HERE FOR TESTING : ]  " + data["word"] + "\n\n"
            jum_word = data["word"]

            code = 3
        end    
        if code == 3 # Show one def or syn
             if related_word_len != 0 && flag == 1
                 puts "HINT :: Synonym / Antonym : " + related_word_arr[0] + "\n"
                 # Delete the hint from Array
                 related_word_arr.delete(related_word_arr[0])

                 related_word_len = related_word_len - 1
                 flag = 0
                 if word_def_cnt == word_def_len
                    flag = 1
                 end   
             elsif word_def_cnt < word_def_len && flag == 0
                puts "HINT :: Word Definition : " + data_def[word_def_cnt]["text"] + "\n"
                word_def_cnt = word_def_cnt + 1
                flag = 1
                if related_word_len == 0
                    flag = 0
                end
                puts flag
             end
             if(related_word_cnt == related_word_len && word_def_cnt == word_def_len)
                puts "HINT :: Jumbled Word : " + jum_word.split(//).sort_by{rand}.join
             end          
        end    
        
        puts "Guess the word : "

        user_word = gets.chomp()
    
        if random_word == user_word || isRelated_Word(user_word,data_syn_ant[0]["words"])
            score = score + 10
            puts "\nCongratulations!! You guessed the right ans :) \n"
            puts "Your Score :" + score.to_s + "\n"
            puts "1 - Play Once Again\n"
            puts "2 - Exit\n"
            ch = gets.chomp()
            case ch
                when '1'
                    puts Fetch_data
                    code = 2
                    score = 0
                when '2'
                    break
                else
                    puts "Invalid Input\n"    
            end         
        else
           score = score - 2
           puts "\nWrong Answer :(\n"
           puts "Your Score :" + score.to_s + "\n"
           puts "Choice any of the option below :\n\n"
           puts "1 - Try Again.\n"
           puts "2 - Want a hint.\n"
           puts "3 - Skip\n"
           puts "4 - Exit from game\n"
           puts "Your option : "
           opt = gets.chomp()
           puts opt
           case opt
            when '1'
                code = 0
            when '2'
                score = score - 3
                code = 3
            when '3'
                score = score - 4
                code = 1
            when '4'
                 break
            else
                puts "Invalid Input\n"         
           end        
        end    
    end  
end


