module Tasks
  class TodayController < ApplicationController
    def index
      render inertia: 'TodayPage', props: { tasks: collection }
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

    def collection
      @collection ||= TaskService.fetch_today_tasks.select { |task| task[:text].present? }
    end

    def resource
      Task.find(params[:task][:id])
    end
  end
end
