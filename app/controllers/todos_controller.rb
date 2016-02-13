class TodosController < ApplicationController

  def new

  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to('')
  end

  def show
    @todo = Todo.new
    @list = Todo.all
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.save
    redirect_to('')
  end

  def update
    redirect_to('')
  end

  private

    def todo_params
      params.require(:todo).permit(:item)
    end

end
