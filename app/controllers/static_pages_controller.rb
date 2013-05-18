class StaticPagesController < ApplicationController
  def home
    @user = current_user if signed_in?
    @item = current_user.items.build if signed_in?
    @items = @user.items.paginate(page: params[:page]) if signed_in?
  end

  def help
  end

  def about
  end

  def sitemap
  end
end
