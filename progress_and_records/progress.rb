class Progress
  attr_reader :from_date, :to_date, :person

  def initialize(from_date, to_date, person)
    @from_date = from_date
    @to_date = to_date
    @person = person
  end

  def squat
    db = SQLite3::Database.new("strength_training.db")
    period = db.execute("select date, squat from #{person.name} order by date").select { |date| from_date <= date[0] and date[0] <= to_date and date[1] != -1 }
    period.last[1] - period.first[1]
  end

  def deadlift
    db = SQLite3::Database.new("strength_training.db")
    period = db.execute("select date, deadlift from #{person.name} order by date").select { |date| from_date <= date[0] and date[0] <= to_date and date[1] != -1 }
    period.last[1] - period.first[1]
  end

  def bench_press
    db = SQLite3::Database.new("strength_training.db")
    period = db.execute("select date, bench_press from #{person.name} order by date").select { |date| from_date <= date[0] and date[0] <= to_date and date[1] != -1 }
    period.last[1] - period.first[1]
  end

  def shoulder_press
    db = SQLite3::Database.new("strength_training.db")
    period = db.execute("select date, shoulder_press from #{person.name} order by date").select { |date| from_date <= date[0] and date[0] <= to_date and date[1] != -1 }
    period.last[1] - period.first[1]
  end

  def pull_up
    db = SQLite3::Database.new("strength_training.db")
    period = db.execute("select date, pull_up from #{person.name} order by date").select { |date| from_date <= date[0] and date[0] <= to_date and date[1] != -1 }
    period.last[1] - period.first[1]
  end
end

# a = StrengthTraining.new("dragan", 20, 72, 172, "5x6")
# p Progress.new(Date.new(2013, 8, 12), Date.new(2013, 9, 20), a).squat
# p Progress.new(Date.new(2013, 8, 12), Date.new(2013, 9, 20), a).deadlift
# p Progress.new(Date.new(2013, 8, 12), Date.new(2013, 9, 20), a).bench_press
# p Progress.new(Date.new(2013, 8, 12), Date.new(2013, 9, 20), a).shoulder_press
# p Progress.new(Date.new(2013, 8, 12), Date.new(2013, 9, 20), a).pull_up