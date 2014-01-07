require 'sqlite3'

class StrengthTraining
  attr_accessor :name, :age, :weight, :height, :training_program

  class UserAlreadyExists < ArgumentError; end

  def initialize(name, age, weight, height, training_program)
    @name = name
    @age = age
    @weight = weight
    @height = height
    @training_program = training_program

    set_person_database
  end

  def set_person_database
    db = SQLite3::Database.new("strength_training.db")
    db.execute("create table if not exists users (name varchar(30),
                                                  age integer,
                                                  weight integer,
                                                  height integer,
                                                  training_program varchar(4));"
    )
    if db.execute("select name from users").all? { |user| user[0] != name }
      db.execute("insert into users values ('#{name}', #{age}, #{weight}, #{height}, '#{training_program}')")
    else
      raise UserAlreadyExists
    end
  end

  def set_workout(workout)
    if (@weight - workout.momentary_weight).abs > 1
      weight = workout.momentary_weight
      db = SQLite3::Database.new("strength_training.db")
      db.execute("update users set weight = #{weight} where name = '#{name}'")
    end
    workout.set_workout_database(self)
  end
end

class Workout
  attr_reader :date, :momentary_weight, :squat, :deadlift, :bench_press, :shoulder_press, :pull_up

  class DateAlreadyExists < ArgumentError; end

  def initialize(date = Date::today, momentary_weight, squat, deadlift, bench_press, shoulder_press, pull_up)
    @date = date
    @momentary_weight = momentary_weight
    @squat = squat
    @deadlift = deadlift
    @bench_press = bench_press
    @shoulder_press = shoulder_press
    @pull_up = pull_up
  end

  def set_workout_database(person)
    db = SQLite3::Database.new("strength_training.db")
    db.execute("create table if not exists #{person.name} (date varchar(10),
                                                          weight integer,
                                                          squat integer,
                                                          deadlift integer,
                                                          bench_press integer,
                                                          shoulder_press integer,
                                                          pull_up integer);"
    )
    if db.execute("select date from #{person.name}").all? { |date_from_data| date_from_data[0] != date.to_s }
      db.execute("insert into #{person.name} values ('#{date.to_s}', #{momentary_weight}, #{squat}, #{deadlift}, #{bench_press}, #{shoulder_press}, #{pull_up})")
    else
      raise DateAlreadyExists
    end
  end
end

a = StrengthTraining.new("antonio", 20, 72, 172, "5x6")
a.set_workout(Workout.new(Date.new(2013, 9, 8), 74, 80, -1, 80, -1, 40))