require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def index
  end

  def new
    @letters = []
    @letters << ("A".."Z").to_a.sample until @letters.length == 10
  end

  def score
    @score = 0
    @attempt = params[:attempt].upcase
    @grid = params[:grid].split(" ")
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    word = JSON.parse(URI.open(url).read)["found"]
    grid_test = @attempt.upcase.chars.all? { |letter| @attempt.upcase.count(letter) <= @grid.count(letter) }
    if @attempt.length == 0
      @result = "Please enter a word!"
    elsif grid_test != true
      @result = "Sorry, but <strong>#{@attempt}</strong> can't be built out of #{@grid.join(", ")}"
    elsif word == false
      @result = "Sorry, but <strong>#{@attempt}</strong> does not seem to be a valid English word."
    else
      @result = "Congratulations, <strong>#{@attempt}</strong> is a valid English word!"
      @score = @attempt.length * 2
    end
  end
end
