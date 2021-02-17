class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  
  def index
    @tasks = Task.all
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
      flash.now[:alert] = 'タイトルを入れてください'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('notice.update')
    else
      flash.now[:alert] = 'タイトルを入れてください'
      render :edit
    end
  end
  
  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: t('notice.destroy')
    else
      flash.now[:alert] = 'タイトルを入れてください'
      render :show
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :content)
  end
end
