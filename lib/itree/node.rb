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

		def resetBalance
			case @balance
			when -1
				@left.balance = 0
				@right.balance = 1
			when 0
				@left.balance = 0
				@right.balance = 0
			when 1
				@left.balance = -1
				@right.balance = 0
			end
			@balance = 0
		end

		def updateMaxScores
			oldNodeMax = 0
			locNode = self
			while locNode
				if locNode.left
					oldNodeMax = locNode.left.scores[1]
					oldNodeMax = (locNode.left.subLeftMax && (oldNodeMax < locNode.left.subLeftMax)) ? locNode.left.subLeftMax : oldNodeMax
					oldNodeMax = (locNode.left.subRightMax && (oldNodeMax < locNode.left.subRightMax)) ? locNode.left.subRightMax : oldNodeMax
					locNode.subLeftMax = oldNodeMax
				else
					locNode.subLeftMax = nil
				end
				if locNode.right
					oldNodeMax = locNode.right.scores[1]
					oldNodeMax = (locNode.right.subLeftMax && (oldNodeMax < locNode.right.subLeftMax)) ? locNode.right.subLeftMax : oldNodeMax
					oldNodeMax = (locNode.right.subRightMax && (oldNodeMax < locNode.right.subRightMax)) ? locNode.right.subRightMax : oldNodeMax
					locNode.subRightMax = oldNodeMax
				else
					locNode.subRightMax = nil
				end
				locNode = locNode.parent
			end
		end
	end
end