class GoController < ApplicationController
  def convert
    word = params[:word]
    url = Link.find_by(name: word)&.url
    if url.blank?
      redirect_to controller: 'links'
    else
      redirect_to url
    end
  end
end
