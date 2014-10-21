class Task < ActiveRecord::Base
  validates :title, presence: true, length: { in: 3..254 }
  validates :location, length: { maximum: 254 }

  before_save:set_due_at

  def set_due_at
    #uses provided due_at or defaults to today
    self.due_at ||=Date.today
  end
end