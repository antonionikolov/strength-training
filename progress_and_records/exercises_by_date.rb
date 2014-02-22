class ExercisesByDate
  attr_reader :date, :person

  def initialize(date, person)
    @date = date.to_s
    @person = person
  end

  def squat
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select squat from #{person.name} where date = '#{date}'")[0][0]
  end

  def deadlift
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select deadlift from #{person.name} where date = '#{date}'")[0][0]
  end

  def bench_press
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select bench_press from #{person.name} where date = '#{date}'")[0][0]
  end

  def shoulder_press
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select shoulder_press from #{person.name} where date = '#{date}'")[0][0]
  end

  def pull_up
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select pull_up from #{person.name} where date = '#{date}'")[0][0]
  end

  def all_exercises
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select squat, deadlift, bench_press, shoulder_press, pull_up from #{person.name} where date = '#{date}'")[0]
  end
end