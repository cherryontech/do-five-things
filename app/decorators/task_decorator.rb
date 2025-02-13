class TaskDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def as_json_for_today
    {
      task_id: id,
      task_order: order,
      task_text: text,
      completed: daily_task_prog.completed?,
      completed_at: daily_task_prog.completed_at
    }
  end
end
