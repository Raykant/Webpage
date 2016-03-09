class PagesController < ApplicationController

  layout nil
  layout 'application', :except => :weather

  def home
    @todo = Todo.new();
  end

  def weather
    render :layout => false
  end

  def todo
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

    respond_to do |format|
      format.js {}
    end
  end

  def links
    render :layout => false

  end

end
