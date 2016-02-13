class PagesController < ApplicationController

  def home
    @todo = Todo.new();
  end

end
