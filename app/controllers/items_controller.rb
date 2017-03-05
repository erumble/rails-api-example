class ItemsController < ApplicationController
  before_action :set_todo
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /todos/:todo_id/items
  def index
    @items = @todo.items

    render json: @items
  end

  # GET /todos/:todo_id/items/1
  def show
    render json: @item
  end

  # POST /todos/:todo_id/items
  def create
    @item = @todo.items.create!(item_params)
    render json: @item, status: :created, location: todo_items_url(@item)
  end

  # PATCH/PUT /todos/:todo_id/items/1
  def update
    @item.update!(item_params)
    render json: @item
  end

  # DELETE /todos/:todo_id/items/1
  def destroy
    @item.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = @todo.items.find(params[:id])
  end

  def set_todo
    @todo = current_user.todos.find(params[:todo_id])
  end

  # Only allow a trusted parameter "white list" through.
  def item_params
    params.require(:item).permit(:name, :done)
  end
end
