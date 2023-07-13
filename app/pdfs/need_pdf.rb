class NeedPdf < Prawn::Document
    def initialize(data)
      Prawn::Fonts::AFM.hide_m17n_warning = true
      super(margin: 0)
      prepare_data(data)
      add_coverpage
      add_index
      add_summary
      add_recommendation_and_requirement
      add_way_ahead
      add_conclusion
      save_pdf
    end

    def add_coverpage
        image "#{Rails.root}/app/assets/images/need_analysis_report/coverstart.png", at: [bounds.left, bounds.top], width: bounds.width, height: bounds.height
        bounding_box([280, 150], width: 220, height: 20) do
            fill_color white
            font_size 13
            text_box @course_name, align: :left, valign: :top
        end
        bounding_box([280, 130], width: 220, height: 20) do
            fill_color white
            font_size 13
            text_box @school_name, align: :left, valign: :top
        end
        bounding_box([280, 110], width: 220, height: 20) do
            fill_color white
            font_size 13
            text_box @academic_year, align: :left, valign: :top
        end
    end

    def add_index
        start_new_page
        image "#{Rails.root}/app/assets/images/need_analysis_report/indexpage.png", at: [bounds.left, bounds.top], width: bounds.width, height: bounds.height
    end

    def add_summary
        start_new_page
        image "#{Rails.root}/app/assets/images/need_analysis_report/summary.png", at: [bounds.left, bounds.top], width: bounds.width, height: bounds.height
        bounding_box([50, bounds.top - 160], width: 220, height: 120) do
            fill_color white
            font_size 13
            text_box @executive_summary, align: :left, valign: :top
        end
        bounding_box([360, bounds.top - 480], width: 220, height: 120) do
            fill_color black
            font_size 13
            text_box @introduction, align: :right, valign: :top
        end
        bounding_box([523, bounds.top - 45], width: 220, height: 120) do
            fill_color white
            font_size 10
            text_box @academic_year, align: :left, valign: :top
        end
    end

    def add_recommendation_and_requirement
        start_new_page
        image "#{Rails.root}/app/assets/images/need_analysis_report/randr.png", at: [bounds.left, bounds.top], width: bounds.width, height: bounds.height
        bounding_box([60, bounds.top - 360], width: 220, height: 120) do
            fill_color black
            font_size 13
            text_box @recommendations_and_requirements[:key_concerns], align: :left, valign: :top
        end
        bounding_box([330, bounds.top - 360], width: 220, height: 120) do
            fill_color black
            font_size 13
            text_box @recommendations_and_requirements[:focus_areas], align: :left, valign: :top
        end
        bounding_box([60, bounds.top - 600], width: 220, height: 120) do
            fill_color black
            font_size 13
            text_box @recommendations_and_requirements[:priority_modules], align: :left, valign: :top
        end
        bounding_box([330, bounds.top - 600], width: 220, height: 120) do
            fill_color black
            font_size 13
            text_box @recommendations_and_requirements[:skillset_needed], align: :left, valign: :top
        end
    end

    def add_way_ahead
        start_new_page
        image "#{Rails.root}/app/assets/images/need_analysis_report/way_ahead.png", at: [bounds.left, bounds.top], width: bounds.width, height: bounds.height
        bounding_box([60, bounds.top - 110], width: 220, height: 110) do
            fill_color black
            font_size 13
            text_box @way_ahead[:way_ahead_summary1], align: :left, valign: :top
        end
        bounding_box([330, bounds.top - 110], width: 220, height: 110) do
            fill_color black
            font_size 13
            text_box @way_ahead[:way_ahead_summary2], align: :left, valign: :top
        end
        bounding_box([60, bounds.top - 340], width: 220, height: 110) do
            fill_color black
            font_size 13
            text_box @way_ahead[:o1], align: :left, valign: :top
        end
        bounding_box([330, bounds.top - 340], width: 220, height: 110) do
            fill_color black
            font_size 13
            text_box @way_ahead[:o2], align: :left, valign: :top
        end
        bounding_box([60, bounds.top - 570], width: 220, height: 110) do
            fill_color black
            font_size 13
            text_box @way_ahead[:o3], align: :left, valign: :top
        end
        bounding_box([330, bounds.top - 570 ], width: 220, height: 110) do
            fill_color black
            font_size 13
            text_box @way_ahead[:o4], align: :left, valign: :top
        end
    end

    def add_conclusion
        start_new_page
        image "#{Rails.root}/app/assets/images/need_analysis_report/conclusion.png", at: [bounds.left, bounds.top], width: bounds.width, height: bounds.height
        bounding_box([50, bounds.top - 100], width: bounds.width-100, height: bounds.height-180) do
            fill_color white
            font_size 13
            text_box @conclusion, align: :left, valign: :top
        end
    end

    def prepare_data(data)
        @school_name = data[:school_name]
        @course_name = data[:course_name]
        @academic_year = data[:academic_year]
        @executive_summary = data[:executive_summary]
        @introduction = data[:introduction]
        @recommendations_and_requirements = data[:recommendations_and_requirements]
        @way_ahead = data[:way_ahead]
        @conclusion = data[:conclusion]
    end
    
    def save_pdf
        output_path = "#{Rails.root}/tmp/need.pdf"
        render_file(output_path)
    end

    def white
        'FFFFFF'
    end

    def black
        '000000'
    end
end
