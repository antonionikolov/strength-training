class Progress
  attr_reader :from_date, :to_date, :person

  def initialize(from_date, to_date, person)
    @from_date = from_date.to_s
    @to_date = to_date.to_s
    @person = person
  end

  def squat
    db = SQLite3::Database.new("strength_training.db")
    period = db.execute("select date, squat from #{person.name} order by date").select { |date| from_date <= date[0] and date[0] <= to_date and date[1] != -1 }
    return 0 if period == []
    period.last[1] - period.first[1]
  end

  def deadlift
    db = SQLite3::Database.new("strength_training.db")
    period = db.execute("select date, deadlift from #{person.name} order by date").select { |date| from_date <= date[0] and date[0] <= to_date and date[1] != -1 }
    return 0 if period == []
    period.last[1] - period.first[1]
  end

  def bench_press
    db = SQLite3::Database.new("strength_training.db")
    period = db.execute("select date, bench_press from #{person.name} order by date").select { |date| from_date <= date[0] and date[0] <= to_date and date[1] != -1 }
    return 0 if period == []
    period.last[1] - period.first[1]
  end

  def shoulder_press
    db = SQLite3::Database.new("strength_training.db")
    period = db.execute("select date, shoulder_press from #{person.name} order by date").select { |date| from_date <= date[0] and date[0] <= to_date and date[1] != -1 }
    return 0 if period == []
    period.last[1] - period.first[1]
  end

  def pull_up
    db = SQLite3::Database.new("strength_training.db")
    period = db.execute("select date, pull_up from #{person.name} order by date").select { |date| from_date <= date[0] and date[0] <= to_date and date[1] != -1 }
    return 0 if period == []
    period.last[1] - period.first[1]
  end
end