class StaticPagesController < ApplicationController
  def home
    @item = current_user.items.build if signed_in?    
  end

  def help
  end

  def about
  end

  def sitemap
  end
end
