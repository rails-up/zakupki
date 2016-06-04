class PagesController < ApplicationController
  def index
    @purchases = Purchase.all.order('created_at DESC').limit(8)
  end

  def about
  end
end
