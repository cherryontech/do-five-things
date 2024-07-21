class TasksController < ApplicationController
  def index
  end

  def create
    task = Task.create(resource_params)
    if task.save
      redirect_to root_path
    else
      redirect_to root_path, status_code: 422, inertia: { errors: task.errors }
    end
  end

  private

  def resource_params
    params.require(:task).permit(:name, :order)
  end
end
