class WelcomeController < ApplicationController
  def index
    @board = Board.new
  end
end
