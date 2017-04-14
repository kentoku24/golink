class GoController < ApplicationController
  def convert
    word, rest = params[:other].split("/", 2) 
    #word = params[:word]
    #this & notation is way too new for heroku, so sticking to old fasion way
    #url = Link.find_by(name: word)&.url
    url = Link.find_by(name: word).try(:url) || Link.where(Link.arel_table[:name].matches(word + "%")).limit(1).try!(:first).try!(:url)
    if url
      if rest
        redirect_to url + "/" + rest
      else
        redirect_to url
      end
    else
      redirect_to controller: 'links', notice: params
    end
  end
end
