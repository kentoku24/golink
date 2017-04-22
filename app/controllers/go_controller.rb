class GoController < ApplicationController
  def convert
    #split given parameter into two by first / charator
    word, rest = params[:other].split("/", 2) 
    
    #case for passing an argument to the link
    unless rest
      #split first argument into two by first " " charactor
      word, spaced_param = word.split(" ", 2)
    end
 
    #this & notation is way too new for heroku, so sticking to old fasioned way
    #url = Link.find_by(name: word)&.url
    
    #search table for exact match, then do prefix search when no match found
    url = Link.find_by(name: word).try(:url) || Link.where(Link.arel_table[:name].matches(word + "%")).limit(1).try!(:first).try!(:url)
    if url
      if rest
        redirect_to url + "/" + rest
      elsif spaced_param
        redirect_to url + spaced_param
      else
        redirect_to url
      end
    else
      redirect_to controller: 'links', notice: params
    end
  end
end
