class SubsController < ApplicationController

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to users_url
  end

  def edit
    @sub = Sub.find(params[:id])
    render :new
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
