module Tasks
  class TodayController < ApplicationController
    def index
      goal = Goal.first.presence || Goal.create!(start_date: Date.current)
      tasks = goal.tasks
      daily_prog = DailyProg.find_or_initialize_by(goal: goal, date: Date.current)
      daily_prog.save! if daily_prog.new_record?

      

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
