class Template
	attr_reader :key
	def initialize(key)
		@key = key
	end

	KEYS = [
		'movie',
		'startup',
		'real_estate',
		'superhero',
		'restaurant',
		'college_course',
		'job_listing'
	]

	def name
		case key
		when 'movie'
			'Movie'
		when 'startup'
			'Startup'
		when 'real_estate'
			'Real Estate Listing'
		when 'superhero'
			'Superhero'
		when 'restaurant'
			'Restaurant'
		when 'college_course'
			'College Course'
		when 'job_listing'
			'Job Listing'
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
		when 'superhero'
			'Our superhero so far...'
		when 'restaurant'
			'The restaurant so far...'
		when 'college_course'
			'Course description so far...'
		when 'job_listing'
			'The job listing so far...'
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
		when 'superhero'
			'Vote for best superhero!'
		when 'restaurant'
			'Vote for best restaurant!'
		when 'college_course'
			'Vote for best course description!'
		when 'job_listing'
			'Vote for best job listing!'
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
		when 'superhero'
			Superhero::BLANKS
		when 'restaurant'
			Restaurant::BLANKS
		when 'college_course'
			CollegeCourse::BLANKS
		when 'job_listing'
			JobListing::BLANKS
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
	      	prompt: 'Pick a real-life tech company',
	        prefix: 'I’m working on a super stealth startup. It’s like',
	        suffix: '',
	      },
	    ],
	    [
	      :audience,
	      {
	        prefix: 'but for',
	        suffix: '.',
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
	      	prompt: 'Choose a location',
	      	prefix: 'Located in',
	        suffix: '',
	      },
	    ],
	    [
	      :type,
	      {
	      	prefix: ', this',
	        suffix: 'property is ready for its next owner!',
	      },
	    ],
	    [
	      :scenery,
	      {
	      	prefix: 'Outside, enjoy views of',
	        suffix: '.',
	      },
	    ],
	    [
	      :amenity,
	      {
	      	prefix: 'Inside, enjoy the recently updated',
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

	module Superhero
		BLANKS = [
	  	[
	      :power,
	      {
	        prefix: 'This hero has the power to',
	        suffix: '.',
	      },
	    ],
	    [
	      :job,
	      {
	      	prefix: 'They used to be a(n)',
	        suffix: '',
	      },
	    ],
	    [
	      :event,
	      {
	      	prefix: ', but one fateful day,',
	        suffix: '.',
	      },
	    ],
	    [
	      :goal,
	      {
	      	prefix: 'From then on, this hero vowed to',
	        suffix: '.',
	      },
	    ],
	    [
	      :villain,
	      {
	      	prefix: 'Their arch nemesis is',
	        suffix: '',
	      },
	    ],
	    [
	      :villain_action,
	      {
	      	prefix: ', who',
	        suffix: '.',
	      },
	    ],
	    [
	      :weakness,
	      {
	      	prefix: "The hero's one weakness is",
	        suffix: '.',
	      },
	    ],
	    [
	      :title,
	      {
	      	prefix: 'And they go by the name "',
	        suffix: '"',
	      },
	    ],
	  ]
	end

	module Restaurant
		BLANKS = [
	  	[
	      :cuisine,
	      {
	      	prompt: 'Pick a type of restaurant',
	        prefix: 'Check out this',
	        suffix: 'restaurant',
	      },
	    ],
	    [
	      :style,
	      {
	      	prefix: 'known for its',
	        suffix: 'dishes',
	      },
	    ],
	    [
	      :influence,
	      {
	      	prefix: 'combined with',
	        suffix: 'influences.',
	      },
	    ],
	    [
	      :signature_dish,
	      {
	      	prefix: 'Enjoy their signature dish:',
	        suffix: '',
	      },
	    ],
	    [
	      :side,
	      {
	      	prefix: ', served with a side of',
	        suffix: '.',
	      },
	    ],
	    [
	      :staple,
	      {
	      	prefix: 'Other staples like',
	        suffix: 'fill out the meal.',
	      },
	    ],
	    [
	      :dessert,
	      {
	      	prefix: "For dessert, I recommend a delicious",
	        suffix: '.',
	      },
	    ],
	    [
	      :difference,
	      {
	      	prefix: 'Unlike other restaurants, this place',
	        suffix: '.',
	      },
	    ],
	    [
	      :best_part,
	      {
	      	prefix: 'But the best part of the experience is',
	        suffix: '.',
	      },
	    ],
	    [
	      :title,
	      {
	      	prefix: 'The name of the restaurant is',
	        suffix: '.',
	      },
	    ],
	  ]
	end

	module CollegeCourse
		BLANKS = [
	  	[
	      :subject,
	      {
	        prefix: 'In this course, students study',
	        suffix: '',
	      },
	    ],
	    [
	      :related,
	      {
	      	prefix: 'as related to',
	        suffix: '.',
	      },
	    ],
	    [
	      :area1,
	      {
	      	prefix: "We'll start by examining",
	        suffix: ',',
	      },
	    ],
	    [
	      :area2,
	      {
	      	prefix: "then move on to",
	        suffix: '.',
	      },
	    ],
	    [
	      :knowledge,
	      {
	      	prefix: "By the end of the semester, students will understand",
	        suffix: '',
	      },
	    ],
	    [
	      :learning_outcome,
	      {
	      	prefix: "and will be able to",
	        suffix: '.',
	      },
	    ],
	    [
	      :department,
	      {
	      	prefix: "This course is offered by the department of",
	        suffix: '.',
	      },
	    ],
	    [
	      :prerequisites,
	      {
	      	prefix: "Prerequisites:",
	        suffix: '.',
	      },
	    ],
	    [
	      :title,
	      {
	      	prefix: "Course Name:",
	        suffix: '',
	      },
	    ],
	  ]
	end

	module JobListing
		BLANKS = [
	  	[
	      :role,
	      {
	        prefix: 'Our company is looking to fill the role of',
	        suffix: '.',
	      },
	    ],
	    [
	      :work_with,
	      {
	      	prefix: 'You will work with',
	        suffix: '',
	      },
	    ],
	    [
	      :process,
	      {
	      	prefix: "to ensure",
	        suffix: '.',
	      },
	    ],
	    [
	      :requirement,
	      {
	      	prefix: "You must be able to",
	        suffix: ',',
	      },
	    ],
	    [
	      :responsiblity,
	      {
	      	prefix: "since you will be responsible for",
	        suffix: '.',
	      },
	    ],
	    [
	      :adjective,
	      {
	      	prefix: "",
	        suffix: 'candidates only.',
	      },
	    ],
	    [
	      :field,
	      {
	      	prefix: "Minimum 5 years experience in",
	        suffix: '.',
	      },
	    ],
	    [
	      :bonus,
	      {
	      	prefix: "Bonus if you can",
	        suffix: '.',
	      },
	    ],
	    [
	      :title,
	      {
	      	prefix: "Company Name:",
	        suffix: '',
	      },
	    ],
	  ]
	end
end