class ItemsController < ApplicationController
  before_filter :signed_in_user

  def create
    @item = current_user.items.build(params[:item])
    if @item.save
      flash[:success] = "Item created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end
end