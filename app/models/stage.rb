class Stage < ApplicationRecord
  belongs_to :bed
  enum cycle_stage: [:unused, :tilled, :planted, :growth, :harvest, :post_harvest]

  def start_date_display
    self.start_date.strftime('%Y-%m-%d')
  end

  def due_date_display
    self.due_date.strftime('%Y-%m-%d')
  end

end