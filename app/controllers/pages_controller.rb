class PagesController < ApplicationController
  def home
    @countries = Country.all
  end
end
