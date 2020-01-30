class Stage < ApplicationRecord
  belongs_to :bed
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

end