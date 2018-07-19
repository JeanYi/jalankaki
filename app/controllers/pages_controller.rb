class PagesController < ApplicationController
  def home
    @activities = Activity.order(:activity_date)
  end
end
