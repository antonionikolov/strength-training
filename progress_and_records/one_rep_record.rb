class OneRepRecord
  attr_reader :person

  def initialize(person)
    @person = person
  end

  def squat
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select squat from #{person.name + '_records'}").map { |squat| squat[0] }.max
  end

  def deadlift
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select deadlift from #{person.name + '_records'}").map { |deadlift| deadlift[0] }.max
  end

  def bench_press
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select bench_press from #{person.name + '_records'}").map { |bench_press| bench_press[0] }.max
  end

  def shoulder_press
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select shoulder_press from #{person.name + '_records'}").map { |shoulder_press| shoulder_press[0] }.max
  end

  def pull_up
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select pull_up from #{person.name + '_records'}").map { |pull_up| pull_up[0] }.max
  end

  def squat_deadlift_bench_press
    squat + deadlift + bench_press
  end
end

# a = StrengthTraining.new("dragan", 20, 72, 172, "5x6")
# orr = OneRepRecord.new(a)
# p orr.squat
# p orr.deadlift
# p orr.bench_press
# p orr.shoulder_press
# p orr.pull_up
# p orr.squat_deadlift_bench_press