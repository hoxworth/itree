module Intervals
	class Node
		attr_accessor :data, :scores, :subLeftMax, :subRightMax, :balance, :left, :right, :parent

		def initialize(min,max,data)
			@scores = [min,max]
			@subLeftMax = nil
			@subRightMax = nil
			@balance = 0
			@data = data
		end
	end
end