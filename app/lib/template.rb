class Template
	attr_reader :key
	def initialize(key)
		@key = key
	end

	def name
		case key
		when 'movie'
			'Movie'
		when 'startup'
			'Startup'
		when 'real_estate'
			'Real Estate'
		end
	end

	def partly_filled_out_message
		case key
		when 'movie'
			'The movie so far...'
		when 'startup'
			'The startup so far...'
		when 'real_estate'
			'The listing so far...'
		end
	end

	def voting_title
		case key
		when 'movie'
			'Vote for best picture!'
		when 'startup'
			'Vote for best startup!'
		when 'real_estate'
			'Vote for best listing!'
		end
	end

	def definition
		case key
		when 'movie'
			MoviePitch::BLANKS
		when 'startup'
			Startup::BLANKS
		when 'real_estate'
			RealEstate::BLANKS
		end
	end

	def key_after(key)
		definition.each_with_index do |(key_in_config, config), index|
			if key.to_sym == key_in_config
				return definition[index + 1]&.first
			end
		end
		return nil
	end

	def config_for(blank_key)
		definition.to_h.fetch(blank_key.to_sym)
	end

	def index_of(blank_key)
		definition.index do |key, definition|
      blank_key.to_sym == key
    end
	end

	def first_blank_key
	  definition.first.first
	end

	module MoviePitch
		BLANKS = [
	  	[
	  		:genre1,
	  		{
		  		prompt: 'Pick a movie genre',
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
	        prefix: 'But by the end of the movie,',
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
	end

	module Startup
		BLANKS = [
	  	[
	      :company,
	      {
	      	prompt: 'Pick a tech company',
	        prefix: 'I’m working on a super stealth startup. It’s like',
	        suffix: '',
	      },
	    ],
	    [
	      :audience,
	      {
	        prefix: 'but for',
	        suffix: '',
	      },
	    ],
	    [
	      :problem,
	      {
	        prefix: 'Have you ever had the problem where',
	        suffix: '?',
	      },
	    ],
	    [
	      :technology,
	      {
	        prefix: 'Well, thanks to our',
	        suffix: 'technology',
	      },
	    ],
	    [
	      :solution,
	      {
	        prefix: ', you can just',
	        suffix: 'instead.',
	      },
	    ],
	    [
	      :monetization,
	      {
	        prefix: "We'll make money by",
	        suffix: '.',
	      },
	    ],
	    [
	      :title,
	      {
	        prefix: 'The startup is called',
	        suffix: '.',
	      },
	    ],
	  ]
	end

	module RealEstate
		BLANKS = [
	  	[
	      :location,
	      {
	      	prefix: 'Located in',
	        suffix: '',
	      },
	    ],
	    [
	      :type,
	      {
	      	prefix: ', this',
	        suffix: 'property',
	      },
	    ],
	    [
	      :scenery,
	      {
	      	prefix: 'surrounded by',
	        suffix: 'is ready for its next owner!',
	      },
	    ],
	    [
	      :amenity,
	      {
	      	prefix: 'Enjoy the recently updated',
	        suffix: '',
	      },
	    ],
	    [
	      :material,
	      {
	      	prefix: 'made from real',
	        suffix: '.',
	      },
	    ],
	    [
	      :feature,
	      {
	      	prefix: 'Also notice the stunning',
	        suffix: '.',
	      },
	    ],
	    [
	      :destination,
	      {
	      	prefix: 'Just a short walk to',
	        suffix: '',
	      },
	    ],
	    [
	      :audience,
	      {
	      	prefix: ', this is an ideal property for',
	        suffix: '.',
	      },
	    ],
	    [
	      :title,
	      {
	      	prefix: 'Now make an eye-catching title for this listing:',
	        suffix: '',
	      },
	    ],
	  ]
	end
end