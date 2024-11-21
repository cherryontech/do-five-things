module Tasks
  class TodayController < ApplicationController
    def index
      render inertia: 'TodayPage'
    end

    def edit
      @task = resource
      @task.update(complete: !@task.complete)

      if @task.save
        redirect_to root_path
      else
        redirect_to root_path, status_code: 422, inertia: { errors: @task.errors }
      end
    end

    private

    def resource
      Task.find(resource_params[:task_id])
    end

    def resource_params
      params.require(:task).permit(:name, :order, :task_id)
    end
  end
end