class ProgService
  def self.initialize_progs
    goal = Goal.last.presence || Goal.create!(start_date: Date.current)
    daily_prog = DailyProg.find_or_initialize_by(goal: goal, date: Date.current)
    daily_prog.save! if daily_prog.new_record?
  end
end
