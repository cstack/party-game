class Blank < ApplicationRecord
  belongs_to :story

  validates :value, length: { maximum: 280 }, allow_blank: true

  def config
  	story.template.config_for(self.key)
  end

  def prompt?
    config[:prompt].present?
  end

  def prompt
    config[:prompt]
  end

  def placeholder
    if config[:placeholder].present?
      config[:placeholder]
    else
      "..."
    end
  end

  def prefix
  	result = config[:prefix]
  end

  def suffix
  	config[:suffix]
  end

  def value_or_placeholder
  	value || "..."
  end

  def position
    story.template.index_of(key)
  end
end
