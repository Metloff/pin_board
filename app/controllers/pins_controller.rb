class PinsController < ApplicationController
  before_action :find_pin, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @pins = Pin.order('created_at DESC')
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params)

    if @pin.save
      flash[:success] = 'Pin created!'
      redirect_to @pin
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @pin.update(pin_params)
      flash[:success] = 'Pin was Successfuly updated'
      redirect_to @pin
    else
      render 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to root_path
  end

  def upvote
    @pin.upvote_by current_user
    redirect_to :back
  end



  private

  def find_pin
    @pin = Pin.find(params[:id])
  end

  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end
end
