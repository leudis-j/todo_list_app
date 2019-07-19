class TodosController < ApplicationController

  def index
    @todos = Todo.all
  end

  def list
    @todos = Todo.all
    @todos_completados = []
    @todos_incompletos = []
    @todos.each do |todo|
      if todo.completed
        @todos_completados<<todo
      else
        @todos_incompletos<<todo
      end
    end
    #@todos.group(:completed)
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    redirect_to todos_path if @todo.save
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
    redirect_to todos_path
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to todos_path
  end

  def complete
    @todo = Todo.find(params[:id])
    @todo.completed = true
    @todo.save
    redirect_to(request.env['HTTP_REFERER'])
  end

  private

  def todo_params
    params.require(:todo).permit(:description, :completed)
  end
end
