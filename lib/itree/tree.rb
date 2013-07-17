module Intervals
	class Tree
		attr_accessor :root, :size

		def initialize
			@root = nil
			@size = 0
		end

		def insert(leftScore, rightScore, data=nil)
			node = Node.new(leftScore,rightScore,data)
			success = true

			if @root.nil?
				@root = node
			else
				balance,success = insertNode(@root,node)
			end

			@size = @size + 1 if success
			return success
		end

		private
		def insertNode(locNode,insertNode,updateData=false)
			diff = locNode <=> insertNode

			if diff > 0
				if locNode.left.nil?
					locNode.left = insertNode
					insertNode.parent = locNode
					locNode.balance = locNode.balance - 1
					locNode.updateMaxScores
					if locNode.balance == 0
						return 0,true
					else
						return 1,true
					end
				else
					balanceUpdate,success = insertNode(locNode.left,insertNode,updateData)
					if balanceUpdate != 0
						locNode.balance = locNode.balance - 1
						if locNode.balance == 0
							return 0,success
						elsif locNode.balance == -1
							return 1,success
						end

						if locNode.left.balance < 0
							rightRotation(locNode)
							locNode.balance = 0
							locNode.parent.balance = 0
							locNode.subLeftMax = locNode.parent.subRightMax
							locNode.parent.subRightMax = -Float::INFINITY
						else
							leftRotation(locNode.left)
							rightRotation(locNode)
							locNode.parent.resetBalance

							locNode.subLeftMax = locNode.parent.subRightMax
							locNode.parent.left.subRightMax = locNode.parent.subLeftMax
							locNode.parent.subRightMax = -Float::INFINITY
							locNode.parent.subLeftMax = -Float::INFINITY
						end

						locNode.parent.updateMaxScores
					end
					return 0,success
				end
			elsif diff < 0
				if locNode.right.nil?
					locNode.right = insertNode
					insertNode.parent = locNode
					locNode.balance = locNode.balance + 1
					locNode.updateMaxScores
					if locNode.balance == 0
						return 0,true
					else
						return 1,true
					end
				else
					balanceUpdate,success = insertNode(locNode.right,insertNode,updateData)
					if balanceUpdate != 0
						locNode.balance = locNode.balance + 1
						if locNode.balance == 0
							return 0,success
						elsif locNode.balance == 1
							return 1,success
						end

						if locNode.right.balance > 0
							leftRotation(locNode)
							locNode.balance = 0
							locNode.parent.balance = 0
							locNode.subRightMax = locNode.parent.subLeftMax
							locNode.parent.subLeftMax = -Float::INFINITY
						else
							rightRotation(locNode.right)
							leftRotation(locNode)
							locNode.parent.resetBalance

							locNode.subRightMax = locNode.parent.subLeftMax
							locNode.parent.right.subLeftMax = locNode.parent.subRightMax
							locNode.parent.subRightMax = -Float::INFINITY
							locNode.parent.subLeftMax = -Float::INFINITY
						end

						locNode.parent.updateMaxScores
					end
					return 0,success
				end
			else
				locNode.data = insertNode.data if updateData
				return 0,false
			end
		end

		def leftRotation(locNode)
			newRoot = locNode.right
			locNode.right = newRoot.left
			if locNode.right
				locNode.right.parent = locNode
			end
			newRoot.left = locNode

			newRoot.parent = locNode.parent
			locNode.parent = newRoot
			if newRoot.parent
				if ((newRoot.parent <=> newRoot) > -1)
					newRoot.parent.left = newRoot
				else
					newRoot.parent.right = newRoot
				end
			else
				@root = newRoot
			end
		end

		def rightRotation(locNode)
			newRoot = locNode.left
			locNode.left = newRoot.right
			if locNode.left
				locNode.left.parent = locNode
			end
			newRoot.right = locNode

			newRoot.parent = locNode.parent
			locNode.parent = newRoot
			if newRoot.parent
				if ((newRoot.parent <=> newRoot) > -1)
					newRoot.parent.left = newRoot
				else
					newRoot.parent.right = newRoot
				end
			else
				@root = newRoot
			end
		end

		def stabNode(node, minScore, maxScore, results)
			if node.subRightMax &&
				 minScore > node.subRightMax &&
				 node.subLeftMax &&
				 minScore > node.subLeftMax &&
				 minScore > node.scores[1]
				return
			end
			if node.left
				stabNode(node.left, minScore, maxScore, results)
			end

			if minScore >= node.scores[0] && maxScore <= node.scores[1]
				results << node.clone
			end

			return if maxScore < node.scores[0]

			if node.right
				stabNode(node.right, minScore, maxScore, results)
			end
		end
	end
end