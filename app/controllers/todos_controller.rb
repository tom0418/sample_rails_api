class TodosController < BaseController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @todos = Todo.all
    render json: @todos, status: :ok
  end

  # POST /todos
  def create
    @todo = Todo.create!(todo_params)
    render json: @todo, status: 201
  end

  # GET /todos/:id
  def show
    render json: @todo, status: :ok
  end

  # PUT /todos/:id
  def update
    @todo.update!(todo_params)
    head :no_content, location: todo_path(@todo)
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy!
    head :no_content
  end

  private

  def todo_params
    # whitelist params
    params.require(:todo).permit(:title, :created_by)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
