class SuggestController < ApplicationController
  def search
    puts params[:search_term]
    links = Link.where(Link.arel_table[:name].matches(params[:search_term] + "%"))
    puts links
    names, urls = links.reduce([[],[]]) { |memo, elem| 
          memo[0].push(elem.name)
          memo[1].push(elem.url)
          memo
        }

    render json: [params[:search_term], names, urls]
  end

end
