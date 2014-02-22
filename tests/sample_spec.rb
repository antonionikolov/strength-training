describe "strength_training" do
  ivan = StrengthTraining.new("ivan", 20, 72, 172, "5x6", "ivan")
  ivan.set_workout_data(Workout.new(Date.new(2013, 9, 8), 74, 80, 90, -1, -1, 40))
  ivan.set_workout_data(Workout.new(Date.new(2013, 9, 19), 74, 90, -1, 90, -1, 50))
  ivan.set_workout_data(Workout.new(Date.new(2013, 9, 12), 74, 85, -1, 85, -1, 45))
  ivan.set_workout_data(Workout.new(Date.new(2013, 8, 12), 74, 70, -1, 70, -1, 35))
  ivan.set_workout_data(Workout.new(Date.new(2013, 10, 12), 76, 100, 120, -1, -1, 30))

  it "exercises by date" do
    ExercisesByDate.new(Date.new(2013, 9, 8), ivan).squat.should eq 80
    ExercisesByDate.new(Date.new(2013, 9, 8), ivan).deadlift.should eq 90
    ExercisesByDate.new(Date.new(2013, 9, 8), ivan).bench_press.should eq -1
    ExercisesByDate.new(Date.new(2013, 9, 8), ivan).shoulder_press.should eq -1
    ExercisesByDate.new(Date.new(2013, 9, 8), ivan).pull_up.should eq 40
    ExercisesByDate.new(Date.new(2013, 9, 8), ivan).all_exercises.should eq [80, 90, -1, -1, 40]

    ExercisesByDate.new(Date.new(2013, 9, 19), ivan).squat.should eq 90
    ExercisesByDate.new(Date.new(2013, 9, 19), ivan).deadlift.should eq -1
    ExercisesByDate.new(Date.new(2013, 9, 19), ivan).bench_press.should eq 90
    ExercisesByDate.new(Date.new(2013, 9, 19), ivan).shoulder_press.should eq -1
    ExercisesByDate.new(Date.new(2013, 9, 19), ivan).pull_up.should eq 50
    ExercisesByDate.new(Date.new(2013, 9, 19), ivan).all_exercises.should eq [90, -1, 90, -1, 50]

    ExercisesByDate.new(Date.new(2013, 9, 12), ivan).squat.should eq 85
    ExercisesByDate.new(Date.new(2013, 9, 12), ivan).deadlift.should eq -1
    ExercisesByDate.new(Date.new(2013, 9, 12), ivan).bench_press.should eq 85
    ExercisesByDate.new(Date.new(2013, 9, 12), ivan).shoulder_press.should eq -1
    ExercisesByDate.new(Date.new(2013, 9, 12), ivan).pull_up.should eq 45
    ExercisesByDate.new(Date.new(2013, 9, 12), ivan).all_exercises.should eq [85, -1, 85, -1, 45]

    ExercisesByDate.new(Date.new(2013, 8, 12), ivan).squat.should eq 70
    ExercisesByDate.new(Date.new(2013, 8, 12), ivan).deadlift.should eq -1
    ExercisesByDate.new(Date.new(2013, 8, 12), ivan).bench_press.should eq 70
    ExercisesByDate.new(Date.new(2013, 8, 12), ivan).shoulder_press.should eq -1
    ExercisesByDate.new(Date.new(2013, 8, 12), ivan).pull_up.should eq 35
    ExercisesByDate.new(Date.new(2013, 8, 12), ivan).all_exercises.should eq [70, -1, 70, -1, 35]

    ExercisesByDate.new(Date.new(2013, 10, 12), ivan).squat.should eq 100
    ExercisesByDate.new(Date.new(2013, 10, 12), ivan).deadlift.should eq 120
    ExercisesByDate.new(Date.new(2013, 10, 12), ivan).bench_press.should eq -1
    ExercisesByDate.new(Date.new(2013, 10, 12), ivan).shoulder_press.should eq -1
    ExercisesByDate.new(Date.new(2013, 10, 12), ivan).pull_up.should eq 30
    ExercisesByDate.new(Date.new(2013, 10, 12), ivan).all_exercises.should eq [100, 120, -1, -1, 30]
  end

  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 8), 73, 100, -1, 100, -1, 40))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 10), 73, 101, 130, 100, 70, 50))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 12), 73, -1, 150, 120, -1, 60))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 15), 73, 140, 140, -1, 80, -1))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 18), 73, 130, -1, 115, 75, -1))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 21), 74, 130, 180, -1, -1, 30))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 23), 73, -1, 180, 120, -1, 45))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 24), 73, 140, 180, 120, 80, 50))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 26), 73, -1, 180, 120, -1, 60))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 28), 73, 140, 190, -1, 80, -1))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 9, 30), 73, 145, -1, 125, 85, -1))
  ivan.set_one_rep_data(OneRep.new(Date.new(2013, 10, 01), 74, 150, 200, -1, -1, 50))
  orr = OneRepRecord.new(ivan)

  it "one rep record" do
    orr.squat.should eq 150
    orr.deadlift.should eq 200
    orr.bench_press.should eq 125
    orr.shoulder_press.should eq 85
    orr.pull_up.should eq 60
    orr.squat_deadlift_bench_press.should eq 475
  end

  it "progress" do
    Progress.new(Date.new(2013, 8, 12), Date.new(2013, 9, 20), ivan).squat.should eq 20
    Progress.new(Date.new(2013, 8, 12), Date.new(2013, 9, 20), ivan).deadlift.should eq 0
    Progress.new(Date.new(2013, 8, 12), Date.new(2013, 9, 20), ivan).bench_press.should eq 20
    Progress.new(Date.new(2013, 8, 12), Date.new(2013, 9, 20), ivan).shoulder_press.should eq 0
    Progress.new(Date.new(2013, 8, 12), Date.new(2013, 9, 20), ivan).pull_up.should eq 15
  end

  it "training program record" do
    tpr = TrainingProgramRecord.new(ivan)
    tpr.squat.should eq 100
    tpr.deadlift.should eq 120
    tpr.bench_press.should eq 90
    tpr.shoulder_press.should eq -1
    tpr.pull_up.should eq 50
  end
end