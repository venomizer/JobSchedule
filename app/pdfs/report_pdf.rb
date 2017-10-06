class ReportPdf < Prawn::Document
  def initialize(jobs)
    super(page_size: [792, 1224], page_layout: :landscape)
    @jobs = jobs
    report_title
    line_items
  end

  def report_title
    text "Active Jobs - Production Team - #{Time.now.strftime('%B %d, %Y')}",
         size: 20,
         style: :bold,
         align: :center
  end

  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      column(0..9).align = :center
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
      self.position = :center
      self.column_widths = [75, 100, 110, 265, 60, 60, 75, 215, 60, 75]
    end
  end

  def line_item_rows

    [['Job Num.','P.O. Date', 'Customer', 'Description', 'Require BoM?', 'BoM Done?', 'Status', 'Progress', 'Priority', 'Finished?']] +
        @jobs.map do |job|
          %W(#{job.jobNum} #{job.poDate.try(:strftime, '%b %d, %Y')} #{job.customer} #{job.description} #{job.needBom? ? 'Yes':'No'} #{job.bomDone? ? 'Yes':'No'} #{job.status}
             #{job.progress} #{job.priority} #{job.finished? ? 'Yes':'No'})
        end
  end
end
