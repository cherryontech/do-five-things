class SettingsPageController < ApplicationController
  def index
    render inertia: 'SettingsPage', props: { tasks: Task.today.order(:order) }
  end

  def bulk_create
    tasks_with_ids, tasks_without_ids = resource_params[:tasks].partition { |t| t['id'].present? }

    if tasks_with_ids.any?
      ids = tasks_with_ids.map { |t| t['id'] }
      tasks = Task.where(id: ids)
      tasks.each do |task|
        param_task = tasks_with_ids.find { |t| t[:id] == task.id }
        task.update!(param_task)
      end
    end

    if tasks_without_ids.any?
      valid_tasks = tasks_without_ids.select do |task|
        t = Task.new(task)
        t if t.valid?
      end
      Task.create!(valid_tasks)
    end

    redirect_to root_path
  rescue StandardError => e
    redirect_to root_path, status_code: 422, inertia: { errors: e.message }
  end

  private

  def resource_params
    params.permit(tasks: %i[id text order completed])
  end
end
