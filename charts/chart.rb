require '../strength_training'
require 'googlecharts'
require 'rchart'

module Charts
  class ChartData
    def initialize(exercise)
      @exercise = exercise
      @date_weight = {}
    end

    attr_reader :exercise, :date_weight

    def set_exercise(date, value)
      @date_weight[date] = value if @date_weight[date] == nil
    end

    def draw(graphic)
      graphic.draw(self)
    end

    def render_as(renderer)
      renderer.new.set_render(self)
    end
  end

  module Renderers
    class GoogleCharts
      def set_render(chart_data)
        exercise_data = chart_data.date_weight.values != [] ? chart_data.date_weight.values : [0]

        line_chart = Gchart.new(
                    :size => '700x400',
                    :bar_colors => ['0088FF', '000000'],
                    :title => "#{chart_data.exercise + " chart"}",
                    :bg => 'EFEFEF',
                    :data => [exercise_data, []],
                    :filename => 'line_chart.png',
                    :stacked => false,
                    :axis_with_labels => [['x'], ['y']],
                    :max_value => exercise_data.max + 30,
                    :min_value => 0,
                    :axis_labels => [[chart_data.date_weight.keys.join('|')]],
                    )
        line_chart.file
      end
    end

    class RChart
      def set_render(chart_data)
        exercise_data = chart_data.date_weight.values != [] ? chart_data.date_weight.values : [0]
        p = Rdata.new
        p.add_point(exercise_data,"Serie1")
        p.add_point(chart_data.date_weight.keys,"Serie2")
        p.add_all_series()
        p.remove_serie("Serie2")
        p.set_abscise_label_serie("Serie2")
        ch = Rchart.new(700,400)

        ch.set_font_properties("tahoma.ttf",8)
        ch.set_graph_area(50,30,680,360)
        ch.draw_filled_rounded_rectangle(7,7,693,393,5,240,240,240)
        ch.draw_rounded_rectangle(5,5,695,395,5,230,230,230)
        ch.draw_graph_area(255,255,255,true)
        ch.draw_scale(p.get_data,p.get_data_description,Rchart::SCALE_NORMAL,150,150,150,true,0,2,true)
        ch.draw_grid(4,true,230,230,230,50)
        ch.set_font_properties("tahoma.ttf",6)
        ch.draw_treshold(0,143,55,72,true,true)

        ch.draw_line_graph(p.get_data,p.get_data_description)

        ch.set_font_properties("tahoma.ttf",10)
        ch.draw_title(50,22,"#{chart_data.exercise + " chart"}",50,50,50,585)
        ch.render_png("line_chart.png")
      end
    end
  end

  class Graphic
    attr_reader :from_date, :to_date, :person

    def initialize(from_date, to_date, person)
      @from_date = from_date
      @to_date = to_date
      @person = person
    end

    def draw(chart)
      db = SQLite3::Database.new("../strength_training.db")
      period = db.execute("select date, #{chart.exercise} from #{person.name} order by date").select { |date| from_date.to_s <= date[0] and date[0] <= to_date.to_s and date[1] > 0 }
      period.each { |exercise| chart.set_exercise(exercise[0], exercise[1]) }
    end
  end

  class GraphicOneRep
    attr_reader :from_date, :to_date, :person

    def initialize(from_date, to_date, person)
      @from_date = from_date
      @to_date = to_date
      @person = person
    end

    def draw(chart)
      db = SQLite3::Database.new("../strength_training.db")
      period = db.execute("select date, #{chart.exercise} from #{person.name + '_records'} order by date").select { |date| from_date.to_s <= date[0] and date[0] <= to_date.to_s and date[1] > 0 }
      period.each { |exercise| chart.set_exercise(exercise[0], exercise[1]) }
    end
  end
end

# module Charts
#   c = ChartData.new "squat"
#   a = StrengthTraining.new("dragan", 20, 72, 172, "5x6")
#   c.draw GraphicOneRep.new(Date.new(2013, 8, 12), Date.new(2013, 12, 12), a)
#   c.render_as(Renderers::RChart)
# end