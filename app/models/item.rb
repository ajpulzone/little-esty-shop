class Item < ApplicationRecord
  belongs_to :merchant

  enum status: {
    disabled: 0,
    enabled: 1
  }
end
