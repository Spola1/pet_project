class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]
  before_action :authorize_todo_item!
  after_action :verify_authorized

  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    @todo_item.user = current_user

    if @todo_item.save
      flash[:success] = 'Todo item created!'
      redirect_to(todo_list_path(@todo_list))
    else
      flash[:danger] = 'Todo item content can\'t be blank'
      redirect_to(@todo_list)
    end
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)

    flash[:success] = 'Todo item completed!'
    redirect_to(@todo_list)
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])

    if @todo_item.destroy
      flash[:success] = 'Todo List item was deleted.'
    else
      flash[:danger] = 'Todo List item could not be deleted.'
    end
    redirect_to(@todo_list)
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end

  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def authorize_todo_item!
    authorize(@todo_item || TodoItem)
  end
end
