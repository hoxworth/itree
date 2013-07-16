module Intervals
	class Node
		attr_accessor :data, :scores, :subLeftMax, :subRightMax, :balance, :left, :right, :parent

		def initialize(min,max,data)
			raise ArgumentError.new("first agument cannot be greater than second argument") if min > max
			@scores = [min,max]
			@subLeftMax = nil
			@subRightMax = nil
			@balance = 0
			@data = data
		end

		def <=>(other)
			if @scores[0] != other.scores[0]
				@scores[0] <=> other.scores[0]
			else
				other.scores[1] <=> @scores[1]
			end
		end

		def ==(other)
			@scores == other.scores
		end
	end
end