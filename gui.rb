require 'gtk2'
require './cui'

class UserTraining < Gtk::Window
  def initialize
    super

    set_title "Strenght Training"
    signal_connect "destroy" do 
      Gtk.main_quit 
    end

    @exercise = nil
    @user = $user_help
    init_ui

    set_default_size 1200, 500
    set_window_position Gtk::Window::POS_CENTER
    
    show_all
  end

  def init_ui
    table = Gtk::Table.new 15, 6, true

    result_label = Gtk::Label.new("Result:")
    result = Gtk::Label.new("")
    picture = Gdk::Pixbuf.new "empty_chart.png"
    image1 = Gtk::Image.new picture

    cb = Gtk::ComboBox.new
    cb.signal_connect "changed" do |w, e|
        @exercise = w.active_text
    end
    cb.append_text 'squat'
    cb.append_text 'deadlift'
    cb.append_text 'bench_press'
    cb.append_text 'shoulder_press'
    cb.append_text 'pull_up'

    date = Gtk::Entry.new
    momentary_weight = Gtk::Entry.new
    squat = Gtk::Entry.new
    deadlift = Gtk::Entry.new
    bench_press = Gtk::Entry.new
    shoulder_press = Gtk::Entry.new
    pull_up = Gtk::Entry.new
    workout = Gtk::Button.new "Set Workout"
    one_rep_workout = Gtk::Button.new "Set One Rep Workout"
    date_for_exercise = Gtk::Entry.new
    from_date = Gtk::Entry.new
    to_date = Gtk::Entry.new
    exercise_date = Gtk::Button.new "Exercise By Date"
    one_rep_record = Gtk::Button.new "One Rep Record"
    progress = Gtk::Button.new "Progress For Period"
    training_program_record = Gtk::Button.new "Training Program Record"
    graphic = Gtk::Button.new "Graphic For Period"
    one_rep_graphic = Gtk::Button.new "One Rep Graphic For Period"

    table.attach Gtk::Label.new("Date:"), 0, 1, 0, 1
    table.attach date, 1, 3, 0, 1
    table.attach Gtk::Label.new("Momentry weight:"), 0, 1, 1, 2
    table.attach momentary_weight, 1, 3, 1, 2
    table.attach Gtk::Label.new("Squat:"), 0, 1, 2, 3
    table.attach squat, 1, 3, 2, 3
    table.attach Gtk::Label.new("Deadlift:"), 0, 1, 3, 4
    table.attach deadlift, 1, 3, 3, 4
    table.attach Gtk::Label.new("Bench press:"), 0, 1, 4, 5
    table.attach bench_press, 1, 3, 4, 5
    table.attach Gtk::Label.new("Shoulder press:"), 0, 1, 5, 6
    table.attach shoulder_press, 1, 3, 5, 6
    table.attach Gtk::Label.new("Pull up:"), 0, 1, 6, 7
    table.attach pull_up, 1, 3, 6, 7
    table.attach workout, 3, 5, 2, 3
    table.attach one_rep_workout, 3, 5, 4, 5
    table.attach cb, 0, 2, 7, 8
    table.attach one_rep_record, 2, 4, 7, 8
    table.attach training_program_record, 4, 6, 7, 8
    table.attach Gtk::Label.new("Date:"), 1, 2, 9, 10
    table.attach date_for_exercise, 2, 4, 9, 10
    table.attach exercise_date, 4, 6, 9, 10
    table.attach Gtk::Label.new("From Date - To Date:"), 1, 2, 11, 12
    table.attach from_date, 2, 4, 11, 12
    table.attach to_date, 4, 6, 11, 12
    table.attach progress, 2, 4, 12, 13
    table.attach graphic, 2, 4, 13, 14
    table.attach one_rep_graphic, 2, 4, 14, 15

    workout.signal_connect "clicked" do
      result.text = workout date.text, momentary_weight.text.to_i, squat.text.to_i, deadlift.text.to_i, bench_press.text.to_i, shoulder_press.text.to_i, pull_up.text.to_i
    end

    one_rep_workout.signal_connect "clicked" do
      result.text = one_rep_workout date.text, momentary_weight.text.to_i, squat.text.to_i, deadlift.text.to_i, bench_press.text.to_i, shoulder_press.text.to_i, pull_up.text.to_i
    end

    exercise_date.signal_connect "clicked" do
      result.text = exercise_date @exercise, date_for_exercise.text
    end

    one_rep_record.signal_connect "clicked" do
      result.text = one_rep_record @exercise
    end

    progress.signal_connect "clicked" do
      result.text = progress @exercise, from_date.text, to_date.text
    end

    training_program_record.signal_connect "clicked" do
      result.text = training_program_record @exercise
    end

    fixed = Gtk::Fixed.new

    graphic.signal_connect "clicked" do
      chart_data = Charts::ChartData.new @exercise
      chart_data.draw Charts::Graphic.new(from_date.text, to_date.text, @user)
      chart_data.render_as(Charts::Renderers::RChart)
      picture = Gdk::Pixbuf.new "line_chart.png"
      image1 = Gtk::Image.new picture
      fixed.put image1, 0, 0
      show_all
      result.text = "Chart for #{@exercise} sets from #{from_date.text} to #{to_date.text}!"
    end

    one_rep_graphic.signal_connect "clicked" do
      chart_data = Charts::ChartData.new @exercise
      chart_data.draw Charts::GraphicOneRep.new(from_date.text, to_date.text, @user)
      chart_data.render_as(Charts::Renderers::RChart)
      picture = Gdk::Pixbuf.new "line_chart.png"
      image1 = Gtk::Image.new picture
      fixed.put image1, 0, 0
      show_all
      result.text = "Chart for one rep #{@exercise} from #{from_date.text} to #{to_date.text}!"
    end

    fixed.put result_label, 100, 430
    fixed.put result, 150, 430
    fixed.put table, 710, 40
    fixed.put image1, 0, 0

    add fixed
  end
end

class Registration < Gtk::Window
  def initialize
    super

    set_title "Strenght Training"
    signal_connect "destroy" do 
      Gtk.main_quit 
    end
        
    init_ui

    set_default_size 500, 250
    set_window_position Gtk::Window::POS_CENTER
    
    show_all
  end

  def init_ui
    table = Gtk::Table.new 10, 9, true

    table.attach Gtk::Label.new("Registration for new user:"), 0, 3, 0, 2

    name = Gtk::Entry.new
    age = Gtk::Entry.new
    weight = Gtk::Entry.new
    height = Gtk::Entry.new
    training_program = Gtk::Entry.new
    password = Gtk::Entry.new
    password.set_visibility(false)
    new_user_button = Gtk::Button.new "Register and Log In"

    table.attach Gtk::Label.new("Name:"), 0, 1, 2, 3
    table.attach name, 1, 3, 2, 3
    table.attach Gtk::Label.new("Age:"), 0, 1, 3, 4
    table.attach age, 1, 3, 3, 4
    table.attach Gtk::Label.new("Weight:"), 0, 1, 4, 5
    table.attach weight, 1, 3, 4, 5
    table.attach Gtk::Label.new("Height:"), 0, 1, 5, 6
    table.attach height, 1, 3, 5, 6
    table.attach Gtk::Label.new("Program:"), 0, 1, 6, 7
    table.attach training_program, 1, 3, 6, 7
    table.attach Gtk::Label.new("Password:"), 0, 1, 7, 8
    table.attach password, 1, 3, 7, 8
    table.attach new_user_button, 1, 3, 8, 9

    table.attach Gtk::Label.new("Log in if you already have account:"), 5, 9, 0, 2

    user_name = Gtk::Entry.new
    user_password = Gtk::Entry.new
    user_password.set_visibility(false)
    user_button = Gtk::Button.new "Log In"

    table.attach Gtk::Label.new("Name:"), 5, 6, 2, 3
    table.attach user_name, 6, 8, 2, 3
    table.attach Gtk::Label.new("Password:"), 5, 6, 3, 4
    table.attach user_password, 6, 8, 3, 4
    table.attach user_button, 6, 8, 4, 5

    new_user_button.signal_connect "clicked" do 
      if name.text == '' or age.text == '' or weight.text == '' or height.text == '' or training_program.text == '' or password.text == ''
        no_information
      else
        new_user name.text, age.text.to_i, weight.text.to_i, height.text.to_i, training_program.text, password.text
        $user_help = @user
        Gtk.init
          strenght_training = UserTraining.new
        Gtk.main
      end
    end

    user_button.signal_connect "clicked" do
      if user_name.text == '' or user_password.text == ''
        no_information
      else
        user user_name.text, user_password.text
        $user_help = @user
        Gtk.init
          strenght_training = UserTraining.new
        Gtk.main
      end
    end

    add table
  end

  def no_information
    md = Gtk::MessageDialog.new(self,
      Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::WARNING,
      Gtk::MessageDialog::BUTTONS_CLOSE, "Not enough information!")
    md.run
    md.destroy
  end
end

$user_help

Gtk.init
  log_in = Registration.new
Gtk.main