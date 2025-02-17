module Tasks
  class TodayController < ApplicationController
    def index
      tasks = TaskService.fetch_today_tasks
      tasks_with_text = tasks.select { |task| task[:text].present? }
      render inertia: 'TodayPage', props: { tasks: tasks_with_text }
    rescue StandardError => e
      render inertia: 'TodayPage', status_code: 422, props: { errors: e.message }
    end

    def edit
      @task = resource
      @task.update!(completed: params[:task][:completed])

      if @task.valid?
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
