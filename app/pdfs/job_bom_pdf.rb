class JobBomPdf < Prawn::Document
  def initialize(job)
    super(page_size: [792, 1224], page_layout: :landscape)
    @job = job
    @parts = job.parts.all
    report_title
    report_info
  end

  def report_title
    define_grid columns: 24,
                rows: 10

    grid([0,0], [0,20]).bounding_box do
      text "Job #{@job.jobNum}: Bill of Materials",
           size: 18,
           style: :bold,
           align: :left,
           valign: :center
    end

    grid([0,21], [0,23]).bounding_box do
      image "#{Rails.root}/public/rentzelpumpclean_0.png",
            position: :left,
            vposition: :center,
            scale: 0.25
    end
  end

  def report_info
    grid([1,0], [9,23]).bounding_box do
      if @job.parts.exists?
        table line_items do
          self.header = true
          self.position = :center
          self.column_widths = [75, 75, 650, 75, 50, 50, 75]
          self.row_colors = %w(F0F0F0 FFFFFF)
          self.cell_style = {align: :center, valign: :center}
        end

      else
        text ' - No Parts'
      end
    end
  end

  def line_items
    [['Item No.', 'Part No.', 'Description', 'Quantity', 'Total Qty', 'Work Order', 'Status']] +
        @parts.map do |part|
          %W(#{part.item_num} #{part.partNum} #{part.description} #{part.quantity} #{part.totalQuantity} #{part.workOrder} #{part.finished ? 'Finished': 'In Progress'})
        end
  end
end