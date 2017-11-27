class JobBomPdf < Prawn::Document
  def initialize(job)
    super(page_size: [792, 1224], page_layout: :portrait)
    @job = job
    report_title
    report_info
  end

  def report_title
    move_down 25
    image "#{Rails.root}/public/rentzelpumpclean_0.png",
          position: :center,
          scale: 0.75
    move_down 50

    text "Job #{@job.jobNum}: Bill of Materials - #{Time.now.strftime('%b %d, %Y')}",
         size: 24,
         style: :bold,
         align: :center
  end

  def report_info
    move_down 50;
    text "<b><u>Customer:</u></b> #{@job.customer}",
         inline_format: true
  end
end