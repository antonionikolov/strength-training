class OneRep
  attr_reader :date, :momentary_weight, :squat, :deadlift, :bench_press, :shoulder_press, :pull_up

  def initialize(date = Date::today.to_s, momentary_weight, squat, deadlift, bench_press, shoulder_press, pull_up)
    @date = date
    @momentary_weight = momentary_weight
    @squat = squat
    @deadlift = deadlift
    @bench_press = bench_press
    @shoulder_press = shoulder_press
    @pull_up = pull_up
  end

  def set_one_rep_database(person)
    db = SQLite3::Database.new("strength_training.db")
    db.execute("create table if not exists #{person.name + '_records'} (date varchar(10),
                                                                        weight integer,
                                                                        squat integer,
                                                                        deadlift integer,
                                                                        bench_press integer,
                                                                        shoulder_press integer,
                                                                        pull_up integer);"
    )
    if db.execute("select date from #{person.name + '_records'}").all? { |date_from_data| date_from_data[0] != date }
      db.execute("insert into #{person.name + '_records'} values ('#{date}', #{momentary_weight}, #{squat}, #{deadlift}, #{bench_press}, #{shoulder_press}, #{pull_up})")
    end
  end
end

# a = StrengthTraining.new("dragan", 20, 72, 172, "5x6")
# a.set_one_rep_data(OneRep.new(Date.new(2013, 9, 8), 73, 100, -1, 100, -1, 40))
# a.set_one_rep_data(OneRep.new(Date.new(2013, 10, 8), 73, 101, 130, 100, 70, 50))
# a.set_one_rep_data(OneRep.new(Date.new(2013, 11, 8), 73, 110, -1, 120, -1, 60))
# a.set_one_rep_data(OneRep.new(Date.new(2013, 12, 8), 73, 140, -1, 110, -1, 40))
# a.set_one_rep_data(OneRep.new(Date.new(2013, 12, 9), 73, 130, -1, 115, -1, 30))
# a.set_one_rep_data(OneRep.new(Date.new(2013, 12, 10), 74, 130, -1, 115, -1, 30))