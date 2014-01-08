require './strength_training'

class TrainingProgramRecord
  attr_reader :person

  def initialize(person)
    @person = person
  end

  def squat
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select squat from #{person.name}").map { |squat| squat[0] }.max
  end

  def deadlift
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select deadlift from #{person.name}").map { |deadlift| deadlift[0] }.max
  end

  def bench_press
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select bench_press from #{person.name}").map { |bench_press| bench_press[0] }.max
  end

  def shoulder_press
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select shoulder_press from #{person.name}").map { |shoulder_press| shoulder_press[0] }.max
  end

  def pull_up
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select pull_up from #{person.name}").map { |pull_up| pull_up[0] }.max
  end
end

# a = StrengthTraining.new("dragan", 20, 72, 172, "5x6")
# tpr = TrainingProgramRecord.new(a)
# p tpr.squat
# p tpr.deadlift
# p tpr.bench_press
# p tpr.shoulder_press
# p tpr.pull_up