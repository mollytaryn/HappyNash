class Adage < ActiveRecord::Base

  validates :content,
    presence: { message: "can't be blank."},
    format: { with: /[a-zA-Z]/, allow_blank: true, message: "must contain at least one letter." }

  default_scope { order("content ASC") }

  def initialize(content)
    super(content: content)
  end
end
