class ListsController < ApplicationController
  # 1. Update this to point to the method that will find the list
  before_action :set_list, only: [ :show, :destroy ] # Added :show here too to dry up your code!

  def index
    @lists = List.all
  end

  def show
    # @list is now set automatically by the before_action
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    # 2. Fixed 'see_other' to be a symbol ':see_other'
    redirect_to lists_path, status: :see_other, notice: "This list was successfully deleted."
  end

  private

  # 3. Define the method that finds the list from the URL parameter
  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
