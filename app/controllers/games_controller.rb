class GamesController < ApplicationController
  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
    
    if !@included
      @result = "Le mot ne peut pas être créé à partir de la grille d'origine."
    elsif @included && !@english_word
      @result = "Le mot est valide d'après la grille, mais ce n'est pas un mot anglais valide."
    elsif @included && @english_word
      @result = "Le mot est valide d'après la grille et est un mot anglais valide."
    end
  end
    # Ta logique pour les différents scénarios irait ici
  def new
      @letters = Array('A'..'Z').sample(10)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
    json = JSON.parse(response)
    json['found']
  end
end
