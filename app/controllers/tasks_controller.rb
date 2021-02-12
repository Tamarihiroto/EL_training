class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to "/tasks", notice: t('notice.new')
    else
      render 'new', alert: t('alert.new')
    end
  end

  private
  
  def task_params
    params.require(:task).permit(:title, :content)
  end
end
