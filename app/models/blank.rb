class Blank < ApplicationRecord
  belongs_to :movie

  TYPES = [
  	[
  		:genre1,
  		{
	  		prompt: 'Pick a genre',
	  		prefix: 'A(n)',
	  		suffix: 'movie',
	  	},
	  ],
  	[
  		:actor1,
  		{
	  		prefix: 'starring',
	  		suffix: '',
	  	},
	  ],
  	[
  		:role1,
  		{
	  		prefix: 'as a(n)',
	  		suffix: '',
	  	},
	  ],
    [
      :setting,
      {
        prefix: 'in',
        placeholder: '(setting)',
        suffix: '.',
      },
    ],
    [
      :role2,
      {
        prefix: 'They meet a(n)',
        suffix: '',
      },
    ],
    [
      :actor2,
      {
        prefix: 'played by',
        suffix: '.',
      },
    ],
    [
      :goal,
      {
        prefix: 'The protagonist must',
        suffix: '',
      },
    ],
    [
      :problem,
      {
        prefix: ', but there is a problem:',
        suffix: '.',
      },
    ],
    [
      :twist,
      {
        prefix: 'To makes things even worse,',
        suffix: '.',
      },
    ],
    [
      :resolution,
      {
        prefix: 'But by the end of the moive,',
        suffix: '.',
      },
    ],
    [
      :title,
      {
        prompt: 'Now what should the movie be called?',
        prefix: '',
        suffix: '',
      },
    ],
  ]

  class << self
  	def config_for(key)
  		TYPES.to_h.fetch(key.to_sym)
  	end

  	def key_after(key)
  		TYPES.each_with_index do |(key_in_config, config), index|
  			if key.to_sym == key_in_config
  				return TYPES[index + 1]&.first
  			end
  		end
  		return nil
  	end

    def first_key
      TYPES.first.first
    end
  end

  def config
  	self.class.config_for(key)
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
end
