class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:new, :show, :destroy]
  before_action :move_to_edit, except: [:edit]

  def index
    @prototype = Prototype.new
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    Prototype.create(prototype_params)
    if
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype =  Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype =  Prototype.find(params[:id])
  end

  def update
    @prototype =  Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :image, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  def move_to_edit
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
