class StaticPagesController < ApplicationController
  def home
    @user = current_user if signed_in?
    @item = current_user.items.build if signed_in?
    @uncompleted = @user.items.where("completed='f'") if signed_in?
    @completed = @user.items.where("completed='t'") if signed_in?
  end

  def help
  end

  def about
  end

  def sitemap
  end
end
