class StaticPagesController < ApplicationController
  before_filter :redirect_if_signed_in

  def home
  end

  def help
  end
end
