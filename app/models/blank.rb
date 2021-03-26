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

  def prompt
  	if config[:prompt]
  		config[:prompt]
  	else
  		"#{prefix} ... #{suffix}"
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
