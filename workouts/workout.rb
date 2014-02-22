class Workout
  attr_reader :date, :momentary_weight, :squat, :deadlift, :bench_press, :shoulder_press, :pull_up

  def initialize(date = Date::today.to_s, momentary_weight, squat, deadlift, bench_press, shoulder_press, pull_up)
    @date = date.to_s
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
    if db.execute("select date from #{person.name}").all? { |date_from_data| date_from_data[0] != date }
      db.execute("insert into #{person.name} values ('#{date}', #{momentary_weight}, #{squat}, #{deadlift}, #{bench_press}, #{shoulder_press}, #{pull_up})")
    end
  end
end