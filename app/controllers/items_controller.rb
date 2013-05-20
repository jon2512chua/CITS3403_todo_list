class ItemsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:destroy]

  def create
    @item = current_user.items.build(params[:item])
    if @item.save
      flash[:success] = "Item created!"

      # sets schedulers for email reminders

      redirect_to root_url
      # http://stackoverflow.com/questions/7896715/delayed-job-sending-an-email-tomorrow
      UserMailer.delay(run_at: @item.due_date.to_datetime.change({ hour: 18, min: 10 })).todo_today(@user)
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

  private

    def correct_user
      @item = current_user.items.find_by_id(params[:id])
      redirect_to root_url if @item.nil?
    end
end