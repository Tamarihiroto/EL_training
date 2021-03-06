class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  
  def index
    @tasks = Task.extract_current_user(@current_user.id).recent().paginate(params[:page])
  end

  def show
  end

  def new
    @task = Task.new
    @tasks = Task.extract_current_user(@current_user.id).recent().paginate(params[:page])
    render :index
  end

  def create
    @task = Task.new(task_params_create)
    @task.user_id = @current_user.id

    if @task.save
      @tasks = Task.extract_current_user(@current_user.id).recent().paginate(params[:page])
      redirect_to tasks_path
    else
      @tasks = Task.extract_current_user(@current_user.id).recent().paginate(params[:page])
      render :index
    end
  end

  def edit
  end

  def update
    @task.user_id = @current_user.id
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :show
    end
  end
  
  def destroy
    if @task.destroy
      redirect_to tasks_path
    else
      flash.now[:alert] = t('alert.destroy')
      render :show
    end
  end

  def sort_by_order
    sort_data = params[:sort_data].split(',')
    column = sort_column(sort_data[0])
    direction = sort_direction(sort_data[1])
    @tasks = Task.extract_current_user(@current_user.id).sorted(column: column, direction: direction).paginate(params[:page])
    render :index
  end

  def search
    search_params = {
      title: params[:title], 
      status: params[:status]
    }
    if is_search_params_nil?(search_params)
      @tasks = Task.none
    else
      @tasks = Task.extract_current_user(@current_user.id).search(search_params).paginate(params[:page])
    end
    flash.now[:alert] = t('alert.search') if @tasks.empty?
    render :index
  end

  private

  def sort_direction(direction)
    %w[asc desc].include?(direction) ? direction : 'desc'
  end
   
  def sort_column(column)
    Task.column_names.include?(column) ? column : 'created_at'
  end

  def is_search_params_nil?(search_params)
    search_params.values.all?(&:empty?)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

  def task_params_create
    params.permit(:title, :content, :deadline, :status, :priority)
  end
end
