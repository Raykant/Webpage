class TodosController < ApplicationController

  def new
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to root_path }

      format.js {}
    end
  end

  def show
    @todo = Todo.new
    @list = Todo.all
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.save
    respond_to do |format|
      format.html { redirect_to root_path }

      format.js {}
    end
  end

  def update
    redirect_to('')
  end

  private

  def todo_params
    params.require(:todo).permit(:item)
  end

end
