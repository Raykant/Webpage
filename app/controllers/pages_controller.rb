class PagesController < ApplicationController

  layout nil
  layout 'application', :except => :weather

  def home
    @todo = Todo.new();
  end

  def weather
    render :layout => false
  end

end
