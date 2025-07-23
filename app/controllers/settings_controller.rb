class SettingsController < AuthenticatedController
  def index
    tasks = TaskService.fetch_today_tasks
    render inertia: 'SettingsPage', props: { tasks: tasks }
  end

  def bulk_update
    tasks = resource_params[:tasks]
    tasks.each do |task|
      task_record = Task.find(task['id'])
      task_record.update!(task)
    end

    redirect_to root_path
  rescue StandardError => e
    redirect_to root_path, status_code: 422, inertia: { errors: e.message }
  end

  private

  def resource_params
    params.delete(:settings_page)
    params.permit(tasks: %i[id text order completed completed_at])
  end
end
