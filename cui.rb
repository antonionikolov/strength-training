require './strength_training'
require './workouts/workout'
require './workouts/one_rep'
require './progress_and_records/exercises_by_date'
require './progress_and_records/one_rep_record'
require './progress_and_records/progress'
require './progress_and_records/training_program_record'
require './charts/chart'

module Cui
  puts "Enter 'user' your name and password if you have accout, 
  otherwise enter 'new_user' your name, age, weight, height, training program and password."

  def new_user(name, age, weight, height, training_program, password)
    @user = StrengthTraining.new(name, age, weight, height, training_program, password)
    db = SQLite3::Database.new("strength_training.db")
    db.execute("create table if not exists #{@user.name} (date varchar(10),
                                                          weight integer,
                                                          squat integer,
                                                          deadlift integer,
                                                          bench_press integer,
                                                          shoulder_press integer,
                                                          pull_up integer);"
    )
    db.execute("create table if not exists #{@user.name + '_records'} (date varchar(10),
                                                                        weight integer,
                                                                        squat integer,
                                                                        deadlift integer,
                                                                        bench_press integer,
                                                                        shoulder_press integer,
                                                                        pull_up integer);"
    )
    "You are now loged with the username #{name}"
  end

  def user(name, password)
    db = SQLite3::Database.new("strength_training.db")
    db.execute("select name, age, weight, height, training_program, password from users").each do |user|
      @user = StrengthTraining.new(name, user[1], user[2], user[3], user[4], password) if user[0] == name
    end
    raise SecurityError if @user == nil
    "You are now loged with the username #{name}"
  end

  def info
    "Name: #{@user.name}, Age: #{@user.age}, Weight: #{@user.weight}, Height: #{@user.height}, Training program: #{@user.training_program}."
  end

  def log_out
    @user = nil
  end

  def workout(date = Date::today.to_s, momentary_weight, squat, deadlift, bench_press, shoulder_press, pull_up)
    return "Log in with user command!" if @user == nil
    db = SQLite3::Database.new("strength_training.db")
    if db.execute("select date from #{@user.name}").any? { |date_from_data| date_from_data[0] == date }
      return "You have already setted a training on that date!"
    end
    @user.set_workout_data(Workout.new(date, momentary_weight, squat, deadlift, bench_press, shoulder_press, pull_up))
    "You just set a workout on #{date}!"
  end

  def one_rep_workout(date = Date::today.to_s, momentary_weight, squat, deadlift, bench_press, shoulder_press, pull_up)
    return "Log in with user command!" if @user == nil
    db = SQLite3::Database.new("strength_training.db")
    if db.execute("select date from #{@user.name + "_records"}").any? { |date_from_data| date_from_data[0] == date }
      return "You have already setted a training on that date!"
    end
    @user.set_one_rep_data(OneRep.new(date, momentary_weight, squat, deadlift, bench_press, shoulder_press, pull_up))
    "You just set a one rep workout on #{date}!"
  end

  def exercise_date(exercise, date)
    weight = ExercisesByDate.new(date, @user).public_send exercise
    "On #{date} you did #{exercise.to_s} sets with #{weight} kilos!"
  end

  def one_rep_record(exercise)
    weight = OneRepRecord.new(@user).public_send exercise
    "Your one rep #{exercise} record is #{weight}!"
  end

  def progress(exercise, from_date, to_date)
    weight = Progress.new(from_date, to_date, @user).public_send exercise
    "Your progres in #{exercise} kilos from #{from_date} to #{to_date} is #{weight}!"
  end

  def training_program_record(exercise)
    weight = TrainingProgramRecord.new(@user).public_send exercise
    "Your #{exercise} program record is #{weight}!"
  end

  def graphic(exercise, from_date, to_date)
    chart_data = Charts::ChartData.new exercise
    chart_data.draw Charts::Graphic.new(from_date, to_date, @user)
    chart_data.render_as(Charts::Renderers::RChart)
    system("ristretto ./line_chart.png")
    "Chart for #{exercise} sets from #{from_date} to #{to_date}!"
  end

  def one_rep_graphic(exercise, from_date, to_date)
    chart_data = Charts::ChartData.new exercise
    chart_data.draw Charts::GraphicOneRep.new(from_date, to_date, @user)
    chart_data.render_as(Charts::Renderers::RChart)
    system("ristretto ./line_chart.png")
    "Chart for one rep #{exercise} from #{from_date} to #{to_date}!"
  end

  private

  @user
end

include Cui