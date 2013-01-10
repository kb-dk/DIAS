#app/controllers/opgave_controller.rb
class OpgaveController < ApplicationController
  def new
    @opgave = Opgave.new
  end

  def index
     @opgave = Opgave.all
  end



end