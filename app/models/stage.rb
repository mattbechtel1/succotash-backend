class Stage < ApplicationRecord
  belongs_to :bed
  belongs_to :crop, optional: true
  enum status: {
    unused: 'unused', 
    tilled: 'tilled', 
    planted: 'planted', 
    growth: 'growth', 
    harvest: 'harvest', 
    barren: 'barren' 
  }

  def start_date_display
    self.start_date.strftime('%Y-%m-%d')
  end

  def due_date_display
    self.due_date.strftime('%Y-%m-%d')
  end

  def field
    self.bed.field
  end

end