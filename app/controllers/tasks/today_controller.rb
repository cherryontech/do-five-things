module Tasks
  class TodayController < ApplicationController
    def index
      render inertia: 'TodayPage', props: { tasks: Task.today }
    end

    def edit
      @task = resource
      @task.update(completed: params[:task][:completed])

      if @task.save
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
