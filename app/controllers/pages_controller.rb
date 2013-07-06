class PagesController < ApplicationController
  def home
    @countries = Country.find(:all, :order => 'title ASC' )
  end
end
