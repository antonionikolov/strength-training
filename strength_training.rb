require 'sqlite3'
require 'digest'

class StrengthTraining
  attr_reader :name, :age, :weight, :height, :training_program

  def initialize(name, age, weight, height, training_program, password)
    @name = name
    @age = age
    @weight = weight
    @height = height
    @training_program = training_program
    @password = Digest::SHA1.hexdigest(password)

    set_person_database
  end

  def set_person_database
    db = SQLite3::Database.new("strength_training.db")
    db.execute("create table if not exists users (name varchar(30),
                                                  age integer,
                                                  weight integer,
                                                  height integer,
                                                  training_program varchar(4),
                                                  password varchar(100));"
    )
    if db.execute("select name from users").all? { |user| user[0] != name }
      db.execute("insert into users values ('#{name}', #{age}, #{weight}, #{height}, '#{training_program}', '#{@password}')")
    elsif db.execute("select name, password from users").none? do |user|
            @password == user[1] and name == user[0]
          end
      raise SecurityError
    end
  end

  def set_workout_data(workout)
    if (workout.momentary_weight - weight).abs > 1
      weight = workout.momentary_weight
      db = SQLite3::Database.new("strength_training.db")
      db.execute("update users set weight = #{weight} where name = '#{name}'")
    end
    workout.set_workout_database(self)
  end

  def set_one_rep_data(one_rep)
    if (one_rep.momentary_weight - weight).abs > 1
      weight = one_rep.momentary_weight
      db = SQLite3::Database.new("strength_training.db")
      db.execute("update users set weight = #{weight} where name = '#{name}'")
    end
    one_rep.set_one_rep_database(self)
  end
end