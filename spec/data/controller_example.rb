class WidgetsController < ActionController
  def index
    @widgets = Widget.all
  end
end
