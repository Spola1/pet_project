class TodoListsController < ApplicationController
  before_action :set_todo_list, only: %i[ show edit update destroy ]

  # GET /todo_lists
  def index
    @todo_lists = TodoList.all
  end

  # GET /todo_lists/1
  def show
  end

  # GET /todo_lists/new
  def new
    @todo_list = TodoList.new
  end

  # GET /todo_lists/1/edit
  def edit
  end

  # POST /todo_lists
  def create
    @todo_list = TodoList.new(todo_list_params)

    if @todo_list.save
      redirect_to @todo_list, notice: "Todo list was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todo_lists/1
  def update
    if @todo_list.update(todo_list_params)
      redirect_to @todo_list, notice: "Todo list was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /todo_lists/1
  def destroy
    @todo_list.destroy
    redirect_to todo_lists_url, notice: "Todo list was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_list_params
      params.require(:todo_list).permit(:title, :description)
    end
end
