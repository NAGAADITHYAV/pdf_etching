class TempPdf < Prawn::Document
  def initialize(data)
    super(margin: 0)
    add_heading_theme(data[:start_theme])
    start_new_page
    add_report(data)
    start_new_page
    add_ending_theme(data[:end_theme])
    save_pdf(data[:name])
  end

  def add_heading_theme(data)
    image "#{Rails.root}/public/required/hapchi_logo.png", width: 150, at: [bounds.right - 150, bounds.top]
    svg IO.read("#{Rails.root}/public/required/spc.svg"), at: [0, bounds.top], width: 400, height: 300
    fill_color "65a6eb"
    font_size 30
    font_style = { style: :bold, character_spacing: 5 }
    text_box '2022-23', font_style.merge({ at: [50, bounds.top - 280], width: bounds.width - 100, align: :left })
    image "#{Rails.root}/public/required/StartTheme.png", width: bounds.width, height: 450, at: [0, bounds.bottom + 450]
  end

  def add_report(data)
    bounding_box([10, bounds.height - 10], width: bounds.width - 20, height: bounds.height - 30) do
      stroke_color "65A6EB"
      line_width 3

      stroke_bounds
    end
    attach_name_plate
    attach_program_details
    attach_programme_summary
    attach_skills_acquired
    attach_badge(data[:badge])
    attach_areas_to_focous_on
    attch_feedback
    fill_color "65A6EB"
    font_size 10
    text_box "© 2023 Hapchi", at: [0, 15], width: bounds.width, height: 30, align: :center
  end

  def add_ending_theme(end_theme)
    image "#{Rails.root}/public/required/spc3_updated.png", width: bounds.width, height: bounds.height, at: [0, bounds.top]
    svg IO.read("#{Rails.root}/public/required/end/#{end_theme}.svg"), at: [75, bounds.top - 75], width: 450, height: 450, align: :center
  end

  def attach_name_plate
    image "#{Rails.root}/public/required/nametag.png", width: bounds.width-30, height: 80, at: [15, bounds.top-25]
    bounding_box([165, bounds.height - 46 ], width: 200, height: 10) do
      fill_color "FFFFFF"
      font_size 10
      text_box "NAGA ADITHYA", align: :left, valign: :center
    end
    bounding_box([448, bounds.height - 48 ], width: 200, height: 10) do
      fill_color "FFFFFF"
      font_size 10
      text_box "6-A", align: :left, valign: :center
    end
    bounding_box([168, bounds.height - 69 ], width: 200, height: 10) do
      fill_color "FFFFFF"
      font_size 10
      text_box "GOWTHAM MODEL SCHOOL", align: :left, valign: :center
    end
  end

  def attach_program_details
    fill_color "65A6EB"
    font_size 13
    text_box 'COACH NAME:', at: [40, bounds.top-115], width: bounds.width, height: 30, align: :left, style: :bold, character_spacing: 1
    text_box 'PROGRAM NAME:', at: [300, bounds.top-115], width: bounds.width, height: 30, align: :left, style: :bold, character_spacing: 1
    fill_color '000000'
    font_size 13
    text_box "Kanika Sharma", at: [145, bounds.top-115], width: bounds.width, height:30, align: :left
    text_box "Teen Awake Programme", at: [428, bounds.top-115], width: bounds.width, height:30, align: :left
  end

  def attach_programme_summary
    data = ['No. of Sessions', 'Attendance', 'Offline Engagement', 'Online Engagement']
    data2 = ['Value 1', 'Value 2', 'Value 3', 'Value 4']
    (0..3).each do |ind|
      bounding_box([40 + ind*((bounds.width - 80)/4), bounds.height - 150], width: (bounds.width - 80)/4, height: 35) do
        stroke_color "88c0fa"
        line_width 3
        stroke_bounds
        fill_color '88c0fa'
        text_box data[ind], align: :center, size: 12, style: :bold, valign: :center
      end
      bounding_box([40 + ind*((bounds.width - 80)/4), bounds.height - 185], width: (bounds.width - 80)/4, height: 35) do
        stroke_color "88c0fa"
        line_width 3
        stroke_bounds
        fill_color '000000'
        text_box data2[ind], align: :center, size: 12, valign: :center
      end
    end
    fill_color "65A6EB"
    font_size 13
    text_box 'PROGRAM SUMMARY', at: [40, bounds.top - 235], width: bounds.width, height: 30, align: :left, style: :bold, character_spacing: 1
    bounding_box([40, bounds.height - 255], width: (bounds.width - 80), height: 75) do
      stroke_color "88c0fa"
      line_width 3
      stroke_bounds
      fill_color "000000"
      text_box random_text, align: :center, valign: :center
    end
  end

  def attach_skills_acquired
    skills = [['Skill 1', 3], ['Skill 2', 5], ['Skill 3', 2], ['Skill 4', 4], ['Skill 5', 1], ['Skill 6', 4], ['Skill 7', 2], ['Skill 8', 5], ['Skill 9', 3], ['Skill 10', 1]]
    fill_color "65A6EB"
    font_size 13
    text_box 'SKILLS ACQUIRED', at: [40, bounds.top - 340], width: bounds.width, height: 30, align: :left, style: :bold, character_spacing: 1
    bounding_box([40, bounds.height - 360], width: (bounds.width - 80), height: 200) do
      stroke_color "88c0fa"
      line_width 3
      stroke_bounds
      
      stroke_color '88c0fa'
      line_width 1
      vertical_line(0, 200, at: 266)

      4.times do |i|
        stroke_horizontal_line(20, 512, at: 160 - (i * 40))
      end
      skills.each_with_index do |skill, index|
        row = index % 5
        col = index/5
  
        bounding_box([266*col, 200 - (row) * 40], width: 133, height: 40) do
          text_box skill[0], align: :center, valign: :center
        end
        bounding_box([(266*col)+133, 190 - (row) * 40], width: 133, height: 40) do
          image "#{Rails.root}/public/required/rating/#{skill[1]}.png", fit: [bounds.width-3, bounds.height-3], align: :center, valign: :center
        end
      end
    end
  end

  def attach_badge(badge)
    svg IO.read("#{Rails.root}/public/required/Student_report_badges/#{badge}.svg"), at: [25, bounds.top - 580], width: 180, height: 180, align: :center
  end

  def attach_areas_to_focous_on
    fill_color "65A6EB"
    font_size 13
    text_box 'AREA TO FOCUS ON', at: [210, bounds.top - 570], height: 30, align: :left, style: :bold, character_spacing: 1
    bounding_box([210, bounds.height - 590], width: (bounds.width - 250), height: 35) do
      stroke_color "88c0fa"
      line_width 3
      stroke_bounds
      fill_color "000000"
      text_box random_text2, at:[5,bounds.top], align: :left, valign: :center
    end
  end
  
  def attch_feedback
    fill_color "65A6EB"
    font_size 13
    text_box 'FEEDBACK FOR STUDENT', at: [210, bounds.top - 635], height: 30, align: :left, style: :bold, character_spacing: 1
    bounding_box([210, bounds.height - 655], width: (bounds.width - 250), height: 100) do
      stroke_color "88c0fa"
      line_width 3
      stroke_bounds
      fill_color "000000"
      text_box random_text3, at:[5,bounds.top], align: :center, valign: :center
    end
  end
  
  def save_pdf(name)
    output_path = "#{Rails.root}/tmp/#{name}.pdf"
    render_file(output_path)
  end

  def random_text
    "The Mind Empowerment Program is a comprehensive and transformative initiative aimed at enhancing mental well-being and unlocking human potential. Through mindfulness, positive psychology, and cognitive strategies, participants develop resilience, self-awareness, and emotional intelligence. It equips individuals with tools to manage stress, enhance focus."
  end

  def random_text2
    "Belive you can Do it"
  end

  def random_text3
    "Equipping individuals with skills to navigate modren challenges, develop a growth mindset, and cultivate a sense of purpose, the Mind Empowerment Program empowers participants to lead fulfilling and successful lives."
  end
end