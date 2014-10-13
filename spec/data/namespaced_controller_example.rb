class Admin::Local::WidgetsController < ApplicationController
  def index
    @widgets = Admin::Local::Widget.all
  end
end
