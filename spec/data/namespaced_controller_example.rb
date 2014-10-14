class Admin::Local::WidgetsController < ApplicationController
  before_action :find_widget, only: [:show, :update, :destroy]

  def index
    @widgets = Admin::Local::Widget.all
  end

  def new
    @widget = Admin::Local::Widget.new
  end

  def create
    @widget = Admin::Local::Widget.new widget_params
    if @widget.save
      redirect_to admin_local_widgets_path, notice: "Widget created."
    else
      render :new
    end
  end

  def show
  end

  def update
    if @widget.update_attributes widget_params
      redirect_to admin_local_widgets_path, notice: "Widget updated."
    else
      render :show
    end
  end

  def destroy
    if @widget.destroy
      redirect_to admin_local_widgets_path, notice: "Widget deleted."
    else
      redirect_to admin_local_widgets_path, alert: "Couldn't delete widget."
    end
  end

  private

  def find_widget
    @widget = Admin::Local::Widget.find params[:id]
  end

  def widget_params
    params.fetch(:widget)
  end
end
