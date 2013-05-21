class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
      @item = current_user.items.build
      @uncompleted = @user.items.where("completed='f'")
      @completed = @user.items.where("completed='t'")
    end
  end

  def help
  end

  def about
  end

  def sitemap
  end
end
