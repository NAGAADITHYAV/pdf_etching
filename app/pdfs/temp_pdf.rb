class TempPdf < Prawn::Document
  def initialize(data)
    super()
    load_template
    add_heading_theme(data[:start_theme])
    add_report(data[:info])
    add_ending_theme(data[:end_theme])
    save_pdf(data[:name])
  end

  def load_template
    template_path = "#{Rails.root}/public/required/Get_Started_with_Smallpdf.pdf"
    start_new_page(template: template_path)
  end

  def save_pdf(name)
    output_path = "#{Rails.root}/tmp/#{name}.pdf"
    render_file(output_path)
  end

  def 

  def add_ending_theme(end_theme)
    svg IO.read("#{Rails.root}/public/required/#{end_theme}.svg"), at: [0, 600], width: 600
  end
end