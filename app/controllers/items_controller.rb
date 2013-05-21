class ItemsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @item = current_user.items.build(params[:item])
    if @item.save
      flash[:success] = "Item created!"
      redirect_to root_url
    else
      @user = current_user
      @items = @user.items if signed_in?
      render 'static_pages/home'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_url
  end

  def complete
    @item = Item.find(params[:id])
    @item.update_attribute :completed, true
    flash[:success] = "#{@item.name} completed."
    redirect_to root_url
  end

  def update
    @item = Item.find params[:id]
    respond_to do |format|
      if @item.update_attributes params[:item]
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.json { respond_with_bip(@item) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@item) }
      end
    end
  end

  private

    def correct_user
      @item = current_user.items.find_by_id(params[:id])
      redirect_to root_url if @item.nil?
    end
end