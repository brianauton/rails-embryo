class Admin::Local::WidgetsController < ActionController
  def index
    @widgets = Admin::Local::Widget.all
  end
end
