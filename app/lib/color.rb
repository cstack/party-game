class Color
	class << self
		def all
			LOGO_SRGB_COLORS.map do |name, color|
				serialize(lighten(color, 0.5))
			end
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

	LOGO_SRGB_COLORS = {
		RED: [249, 53, 73],
		YELLOW: [243, 229, 0],
		GREEN: [0, 206, 124],
		BLUE: [58, 141, 222],
		VIOLET: [177, 80, 197],
		PINK: [244, 81, 151],
	}

	def self.serialize(color)
		"rgb(#{color[0]}, #{color[1]}, #{color[2]})"
	end

	def self.lighten(color, percent)
		color.map do |value|
			255 - ((255 - value) * (1-percent))
		end
	end

	def self.darken(color, percent)
		color.map do |value|
			value * (1-percent)
		end
	end
end