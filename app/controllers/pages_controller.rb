class PagesController < ApplicationController

  layout nil
  layout 'application', :except => :weather

  def home
    @todo = Todo.new();
  end

  def weather
    render :layout => false
  end

  def todos
    render :layout => false
  end

  def welcome
    render :layout => false
  end

  def todomsg
    render :layout => false
  end

  def background
    render :layout => false
  end

  def links
    render :layout => false

  end

end
