class ImpTempPdf < Prawn::Document
    def initialize(data)
        Prawn::Fonts::AFM.hide_m17n_warning = true
        super(margin: 0)
        prepare_data(data)
        add_heading_cover
        add_index
        add_overview
        add_impact_measurement
        add_stories_of_impact
        add_comparative_analysis
        add_message_from_educators
        add_feedback_and_improvements
        add_ending_cover
        save_pdf
      end
  
      def add_heading_cover
        image "#{Rails.root}/app/assets/images/program_impact_report/startingpage.png", at: [bounds.left, bounds.top], width: bounds.width, height: bounds.height
        bounding_box([70, bounds.top - 275], width: bounds.width-100, height: bounds.height-50) do
            fill_color black
            font_size 25
            text_box @academic_year, align: :left, valign: :top
        end
        bounding_box([380,55], width: bounds.width-100, height: 20) do
            fill_color white
            font_size 13
            text_box @school_name, align: :left, valign: :top
        end
        bounding_box([380, 70], width: bounds.width-100, height: 20) do
            fill_color white
            font_size 13
            text_box @course_name, align: :left, valign: :top
        end
        bounding_box([380, 40], width: bounds.width-100, height: 20) do
            fill_color white
            font_size 13
            text_box @academic_year, align: :left, valign: :top
        end
      end
  
      def add_index
        start_new_page
        image "#{Rails.root}/app/assets/images/program_impact_report/indexpage.png", at: [bounds.left, bounds.top], width: bounds.width, height: bounds.height
      end
  
      def add_overview
        start_new_page
        add_page_heading('Overview')
        bounding_box([50, bounds.top - 100], width: bounds.width-100, height: bounds.height-150) do
          fill_color black
          font_size 14
          text_box @overview, align: :left, valign: :top
        end
        add_footer
      end
  
      def add_impact_measurement
        start_new_page
        add_page_heading('Impact Measurement')
        image "#{Rails.root}/app/assets/images/program_impact_report/graph.png", at: [50, bounds.top-100], width: bounds.width-100, height: 400
        bounding_box([50, bounds.top - 525], width: bounds.width-100, height: 200) do
            fill_color black
            font_size 14
            text_box @impact_measurement, align: :left, valign: :top
          end
        add_footer
      end
  
      def add_stories_of_impact
        start_new_page
        add_page_heading('Stories of Impact')
        @stories_of_impact.each_with_index do |story, index|
            row = (index / 2).to_i
            col = index % 2
            start_x = (276 * col)
            start_y = 720 - (row) * 200
            width = 306
            height = 250
            bounding_box([start_x, start_y], width: width, height: height) do
                svg IO.read("#{Rails.root}/app/assets/images/program_impact_report/story_frame.svg"), at: [bounds.left , bounds.top], width: bounds.width, height: bounds.height, align: :center 
            end
            bounding_box([start_x + 60, start_y - 55], width: (width - 120) , height: (height - 120)) do
                fill_color black
                font_size 10
                text_box story, align: :center, valign: :center
            end           
        end
        add_footer
      end
  
      def add_comparative_analysis
        start_new_page
        add_page_heading('Comparative analysis')
        bounding_box([bounds.left+ 40, bounds.top-80], width: bounds.width , height: 30) do
            fill_color "0056A2"
            font_size 15
            text_box 'Quanti', align: :left, valign: :center, style: :bold
        end
        bounding_box([50, bounds.top-100], height: 40, width: bounds.width)do
            fill_color black
            font_size 15
            text_box 'Pre', align: :left, valign: :center
        end
        bounding_box([306, bounds.top-100], height: 40, width: bounds.width)do
            fill_color black
            font_size 15
            text_box 'Post', align: :left, valign: :center
        end
        bounding_box([53, bounds.top-140], height: 250, width: 220)do
            fill_color black
            font_size 15
            text_box @comparative_analysis[:pre_quanti], align: :left
        end

        bounding_box([309, bounds.top-140], height: 250, width: 220)do
            fill_color black
            font_size 15
            text_box @comparative_analysis[:post_quanti], align: :left
        end

        bounding_box([bounds.left+40, bounds.top-410], width: bounds.width , height: 30) do
            fill_color "0056A2"
            font_size 15
            text_box 'Stories of Impact', align: :left, valign: :center, style: :bold
        end
        bounding_box([bounds.left+50, bounds.top-430], height: 40, width: bounds.width)do
            fill_color black
            font_size 15
            text_box 'Pre', align: :left, valign: :center
        end
        bounding_box([306, bounds.top-430], height: 40, width: bounds.width)do
            fill_color black
            font_size 15
            text_box 'Post', align: :left, valign: :center
        end
        bounding_box([-20, 330], width: 350, height: 250) do
            svg IO.read("#{Rails.root}/app/assets/images/program_impact_report/story_frame.svg"), at: [bounds.left , bounds.top], width: bounds.width, height: bounds.height, align: :center 
        end
        bounding_box([236, 330], width: 350, height: 250) do
            svg IO.read("#{Rails.root}/app/assets/images/program_impact_report/story_frame.svg"), at: [bounds.left , bounds.top], width: bounds.width, height: bounds.height, align: :center 
        end
        bounding_box([55, 275], height: 130, width: 230)do
            fill_color black
            font_size 15
            text_box @comparative_analysis[:pre_story_of_impact], align: :left, valign: :center
        end
        bounding_box([306, 275], height: 130, width: 230)do
            fill_color black
            font_size 15
            text_box @comparative_analysis[:post_story_of_impact], align: :left, valign: :center
        end
        add_footer
      end
  
      def add_message_from_educators
        start_new_page
        add_page_heading('Message from our educators')
        image "#{Rails.root}/app/assets/images/program_impact_report/message_from_educators.png", at: [50, bounds.top-100], width: bounds.width-100, height: 250

        bounding_box([50, bounds.top-360], height: 120, width: (bounds.width-100))do
            fill_color black
            font_size 15
            text_box @message_from_our_educators[0], align: :left, valign: :center
        end
        bounding_box([50, bounds.top-500], height: 120, width: (bounds.width-100))do
            fill_color black
            font_size 15
            text_box @message_from_our_educators[1], align: :left, valign: :center
        end
        bounding_box([50, bounds.top-640], height: 120, width: (bounds.width-100))do
            fill_color black
            font_size 15
            text_box @message_from_our_educators[2], align: :left, valign: :center
        end
        add_footer
      end
  
      def add_feedback_and_improvements
        start_new_page
        add_page_heading('Feedback and Improvement')
        bounding_box([50, bounds.top-100], height: 600, width: (bounds.width-100))do
            fill_color black
            font_size 15
            text_box @feedback_and_improvements, align: :left, valign: :center
        end
        add_footer
      end
  
      def add_ending_cover
        start_new_page
        image "#{Rails.root}/app/assets/images/program_impact_report/ending_page.png", at: [bounds.left, bounds.top], width: bounds.width, height: bounds.height
      end
  
      def prepare_data(data)
        @school_name = data[:school_name]
        @course_name = data[:course_name]
        @academic_year = data[:academic_year]
        @overview = data[:overview]
        @impact_measurement = data[:impact_measurement]
        @stories_of_impact = data[:stories_of_impact][0..6]
        @comparative_analysis = data[:comparative_analysis]
        @message_from_our_educators = data[:message_from_our_educators]
        @feedback_and_improvements = data[:feedback_and_improvements]
      end
  
      def black
        '000000'
      end

      def white
        'FFFFFF'
      end

      def add_footer
        image "#{Rails.root}/app/assets/images/program_impact_report/footer_for_data.png", at: [bounds.left+50, bounds.bottom+20], height: 20, width: bounds.width-100
      end

      def add_page_heading(text = 'SampleText')
        fill_color "0056A2"
        font_size 30
        text_box text, at: [40, bounds.top - 50], width: bounds.width, height: 30, align: :left, style: :bold, character_spacing: 1
      end

      def save_pdf
        output_path = "#{Rails.root}/tmp/imp_pdf.pdf"
        render_file(output_path)
      end
end