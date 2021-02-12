class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]
  
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
      flash[:notice] = 'タスクが作成されました。'
      redirect_to "/tasks"
    else
      flash.now[:alert] = 'タイトルを入れてください'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'タスク内容が編集されました。'
      redirect_to "/tasks"
    else
      flash.now[:alert] = '変更ができません'
      render 'edit'
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
