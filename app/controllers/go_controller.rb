class GoController < ApplicationController
  def convert
    #split given parameter into two by first / charator
    word, rest = params[:other].split("/", 2) 
    
    #case for passing an argument to the link
    unless rest
      #split first argument into two by first " " charactor
      word, spaced_params = word.split(" ", 2)
      spaced_params = spaced_params.try(:split, " ")
    end
 
    #this & notation is way too new for heroku, so sticking to old fasioned way
    #url = Link.find_by(name: word)&.url
    
    #search table for exact match, then do prefix search when no match found
    url = Link.find_by(name: word).try(:url) || \
          Link.where(Link.arel_table[:name].matches(word + "%"))\
                                           .limit(1).try!(:first).try!(:url)
    
    Accesslog.new(word: word, params: rest || spaced_params).save


    if url

      # case1: [word]/path/to/somewhere
      if rest
        redirect_to url + "/" + rest
      
      # case2: [word] arg1 arg2 ...
      elsif spaced_params
        spaced_params.each do |param|
          url.sub!("%s", param)
        end
        redirect_to url

      # case3: [word]
      else
        redirect_to url
      end
    else
      redirect_to controller: 'links', notice: params
    end
  end
end
