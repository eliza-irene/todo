class Task < ActiveRecord::Base
  # TITLE_REGEX = /\A[^a-zA-Z\s\d]{0,5}\z/i
  validates :title, presence: true, length: { in: 3..254 }
            # format: { with: TITLE_REGEX }
end