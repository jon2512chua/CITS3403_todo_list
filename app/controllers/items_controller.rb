class ItemsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:destroy]

  def create
    @item = current_user.items.build(params[:item])
    if @item.save
      flash[:success] = "Item created!"
      # sets schedulers for email reminders
      # http://stackoverflow.com/questions/7896715/delayed-job-sending-an-email-tomorrow
      # UserMailer.delay(run_at: @item.due_date.to_datetime.change({ hour: 22, min: 20 })).todo_today(@user)
      UserMailer.delay(run_at: 1.minute.from_now).todo_today(@user)

      redirect_to root_url
    else
      if signed_in?
        @user = current_user
        @uncompleted = @user.items.where("completed='f'")
        @completed = @user.items.where("completed='t'")
        render 'static_pages/home'
      end
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