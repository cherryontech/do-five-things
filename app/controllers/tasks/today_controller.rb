module Tasks
  class TodayController < ApplicationController
    def index
      tasks = TaskService.fetch_today_tasks
      render inertia: 'TodayPage', props: { tasks: tasks }
    rescue StandardError => e
      redirect_to today_path, status_code: 422, inertia: { errors: e.message }
    end

    def edit
      @task = resource
      @task.update(completed: params[:task][:completed])

      if @task.valid
        redirect_to today_path
      else
        redirect_to today_path, status_code: 422, inertia: { errors: @task.errors }
      end
    end

    private

    def resource
      Task.find(params[:task][:id])
    end
  end
end
