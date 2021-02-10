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
      flash[:notice] = 'タスクが作成されました。'
      redirect_to "/tasks"
    else
      flash.now[:alert] = 'タイトルを入れてください'
      render 'new'
    end
  end

  private
  
  def task_params
    params.require(:task).permit(:title, :content)
  end
end
