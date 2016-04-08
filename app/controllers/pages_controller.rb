class PagesController < ApplicationController
  def index
    @purchases = Purchase.all.limit(8)
  end

  def about
  end
end
