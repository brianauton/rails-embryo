class WidgetsController < ApplicationController
  before_action :find_widget, only: [:show, :update, :destroy]

  def index
    @widgets = Widget.all
  end

  def new
    @widget = Widget.new
  end

  def create
    @widget = Widget.new widget_params
    if @widget.save
      redirect_to widgets_path, notice: "Widget created."
    else
      render :new
    end
  end

  def show
  end

  def update
    if @widget.update_attributes widget_params
      redirect_to widgets_path, notice: "Widget updated."
    else
      render :show
    end
  end

  def destroy
    if @widget.destroy
      redirect_to widgets_path, notice: "Widget deleted."
    else
      redirect_to widgets_path, alert: "Couldn't delete widget."
    end
  end

  private

  def find_widget
    @widget = Widget.find params[:id]
  end

  def widget_params
    params.fetch(:widget)
  end
end
