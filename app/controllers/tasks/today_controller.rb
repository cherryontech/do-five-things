module Tasks
  class TodayController < ApplicationController
    def index
      render inertia: 'TodayPage', props: { tasks: Task.today }
    end

    def edit
      @task = resource
      @task.update(completed: !@task.completed)

      if @task.save
        redirect_to root_path
      else
        redirect_to root_path, status_code: 422, inertia: { errors: @task.errors }
      end
    end

    private

    def resource
      Task.find(params[:task_id])
    end
  end
end
