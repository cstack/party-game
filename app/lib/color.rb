class Color
	class << self
		def all
			[
				RED,
				ORANGE,
				YELLOW,
				GREEN,
				BLUE,
				INDIGO,
				VIOLET,
				PINK,
			]
		end

		def random
			all.shuffle.first
		end
	end
	RED = '#ffadad'
	ORANGE = '#ffd6a5'
	YELLOW = '#fdffb6'
	GREEN = '#caffbf'
	BLUE = '#9bf6ff'
	INDIGO = '#a0c4ff'
	VIOLET = '#bdb2ff'
	PINK = '#ffc6ff'
end