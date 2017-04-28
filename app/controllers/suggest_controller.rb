class SuggestController < ApplicationController
  def search
    puts params[:search_term]
    render json: ["foo", ["foo","bar"]]
  end

end
