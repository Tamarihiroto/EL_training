class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  helper_method :sort_column, :sort_direction
  
  def index
    @tasks = Task.all.order("#{sort_column} #{sort_direction}")
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: t('notice.new')
    else
      flash.now[:alert] = t('alert.new')
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('notice.update')
    else
      flash.now[:alert] = t('alert.update')
      render :edit
    end
  end
  
  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: t('notice.destroy')
    else
      flash.now[:alert] = t('alert.destroy')
      render :show
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
   end
   
   def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'title'
   end

  private

  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :content, :deadline)
  end
end
