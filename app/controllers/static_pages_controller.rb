class StaticPagesController < ApplicationController
  def home
    @user = current_user if signed_in?
    @item = current_user.items.build if signed_in?
    @uncompleted = @user.items.where("completed='f'")
    @completed = @user.items.where("completed='t'")
  end

  def help
  end

  def about
  end

  def sitemap
  end
end
