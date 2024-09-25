class SettingsPageController < ApplicationController
  def index
    render inertia: 'SettingsPage', props: { tasks: Task.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(:order) }
  end

  def bulk_create
    tasks = []
    params[:tasks].each_with_index do |task, idx|
      tasks << { name: task, order: idx }
    end
    begin
      if Task.find_or_create_by(tasks)
        redirect_to root_path
      else
        redirect_to root_path, status_code: 422, inertia: { errors: ['something went wrong'] }
      end
    rescue => e
      redirect_to root_path, status_code: 422, inertia: { errors: [e.message] }
    end
  end
end
