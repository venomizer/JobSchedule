class SingleJobReportPdf < Prawn::Document
  def initialize(job)
    super(page_size: [792, 1224], page_layout: :portrait)
    @job = job.preload(:parts)
    @parts = job.parts.all
    report_title
    report_info
    report_data
  end

  def report_title
    move_down 25
    image "#{Rails.root}/public/rentzelpumpclean_0.png",
          position: :center,
          scale: 0.75
    move_down 50

    text "Job #{@job.jobNum}: Summary Report - #{Time.now.strftime('%b %d, %Y')}",
         size: 24,
         style: :bold,
         align: :center
  end

  def report_info
    move_down 50
    header = ['Job Number', 'Customer', 'PO Date', 'Due Date']
    h_info = %W(#{@job.jobNum} #{@job.customer} #{@job.poDate} #{@job.dueDate})
    header.zip(h_info).each do |head, info|
      text "<b><u>#{head}:</u></b> #{info}",
           inline_format: true
      move_down 10
    end
  end

  def report_data
    move_down 50
    text '<b><u>Description:</u></b>',
         inline_format: true
    move_down 10
    text " - #{@job.description}"
    move_down 50
    text '<b><u>Parts List:</u></b>',
         inline_format: true
    move_down 10

    if @job.parts.exists?
      table line_items do
            self.header = true
            self.position = :center
            self.column_widths = [75, 75, 250, 75, 50, 50, 75]
            self.row_colors = %w(F0F0F0 FFFFFF)
            self.cell_style = {align: :center, valign: :center}
      end

    else
      text ' - No Parts'
    end
    move_down 50
    text "<b><u>Status:</u></b> #{@job.status}",
         inline_format: true
  end

  def line_items
    [['Item No.', 'Part No.', 'Description', 'Quantity', 'Total Qty', 'Work Order', 'Status']] +
        @parts.map do |part|
          %W(#{part.item_num} #{part.partNum} #{part.description} #{part.quantity} #{part.totalQuantity} #{part.workOrder} #{part.finished ? 'Finished': 'In Progress'})
        end
  end
end
