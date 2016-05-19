class SyntaxesController < ApplicationController

  def index
    render json: Syntax.all
  end

end
