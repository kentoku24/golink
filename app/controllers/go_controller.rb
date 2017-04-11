class GoController < ApplicationController
  def convert
    word = params[:word]
    #this & notation is way too new for heroku, so sticking to old fasion way
    #url = Link.find_by(name: word)&.url
    url = Link.find_by(name: word).try(:url)
    if url
      redirect_to url
    else
      redirect_to controller: 'links'
    end
  end
end
