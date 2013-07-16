require 'spec_helper'

describe Intervals::Node do
	context "creation" do
		describe "#initialize" do
			it { Intervals::Node.new(1,2,"taco").scores.should eq [1,2]}
			it { Intervals::Node.new(1,2,"taco").data.should eq "taco"}
			it { Intervals::Node.new(1,2,"taco").balance.should eq 0}
			it { expect { Intervals::Node.new(2,1,"taco") }.to raise_error(ArgumentError)}
		end
	end

	context "comparing" do
		let(:lesser_min_node) { Intervals::Node.new(0,5,nil) }
		let(:greater_min_node) { Intervals::Node.new(1,5,nil) }
		let(:lesser_max_node) { Intervals::Node.new(0,5,nil) }
		let(:greater_max_node) { Intervals::Node.new(0,1,nil) }

		describe "#<=>" do
			it { (lesser_min_node <=> greater_min_node).should eq -1 }
			it { (lesser_min_node <=> lesser_min_node).should eq 0 }
			it { (greater_min_node <=> lesser_min_node).should eq 1 }
			it { (lesser_max_node <=> greater_max_node).should eq -1 }
			it { (lesser_max_node <=> lesser_max_node).should eq 0 }
			it { (greater_max_node <=> lesser_max_node).should eq 1 }
		end

		describe "#==" do
			it { (lesser_min_node == lesser_min_node).should be true }
			it { (lesser_min_node == greater_min_node).should_not be true }
			it { (greater_min_node == greater_min_node).should be true }
		end
	end

	describe "#resetBalance" do
		let(:node) do
			n = Intervals::Node.new(5,10,nil)
			n.left = Intervals::Node.new(0,5,nil)
			n.left.balance = 2
			n.right = Intervals::Node.new(15,20,nil)
			n.right.balance = 2
			n
		end

		it "resets balance to 0" do
			node.balance = 1
			node.resetBalance
			node.balance.should eq 0
		end

		context "when balance is -1" do
			before(:each)  { node.balance = -1 }

			it "sets left child balance to 0" do
				node.resetBalance
				node.left.balance.should eq 0
			end

			it "sets right child balance to 1" do
				node.resetBalance
				node.right.balance.should eq 1
			end
		end

		context "when balance is 0" do
			before(:each)  { node.balance = 0 }

			it "sets left child balance to 0" do
				node.resetBalance
				node.left.balance.should eq 0
			end

			it "sets right child balance to 0" do
				node.resetBalance
				node.right.balance.should eq 0
			end
		end

		context "when balance is 1" do
			before(:each)  { node.balance = 1 }

			it "sets left child balance to -1" do
				node.resetBalance
				node.left.balance.should eq -1
			end

			it "sets right child balance to 0" do
				node.resetBalance
				node.right.balance.should eq 0
			end
		end
	end

	describe "#updateMaxScores" do
		let(:node) do
			n = Intervals::Node.new(5,10,nil)
			n.left = Intervals::Node.new(0,5,nil)
			n.left.parent = n
			n.right = Intervals::Node.new(15,20,nil)
			n.right.parent = n
			n.left.left = Intervals::Node.new(-2,0,nil)
			n.left.left.parent = n.left
			n.left.right = Intervals::Node.new(3,5,nil)
			n.left.right.parent = n.left
			n.right.left = Intervals::Node.new(10,15,nil)
			n.right.left.parent = n.right
			n.right.right = Intervals::Node.new(20,25,nil)
			n.right.right.parent = n.right
			n
		end

		context "left-left child has largest max score" do
			before(:each) { node.left.left.scores[1] = 100 }

			it "sets the maxLeftScore to the max score of the left-left child" do
				node.left.left.updateMaxScores
				node.subLeftMax.should eq node.left.left.scores[1]
			end
		end

		context "left-right child has largest max score" do
			before(:each) { node.left.right.scores[1] = 100 }

			it "sets the maxLeftScore to the max score of the left-right child" do
				node.left.right.updateMaxScores
				node.subLeftMax.should eq node.left.right.scores[1]
			end
		end

		context "right-left child has largest max score" do
			before(:each) { node.right.left.scores[1] = 100 }

			it "sets the maxRightScore to the max score of the right-left child" do
				node.right.left.updateMaxScores
				node.subRightMax.should eq node.right.left.scores[1]
			end
		end

		context "right-right child has largest max score" do
			before(:each) { node.right.right.scores[1] = 100 }

			it "sets the maxRightScore to the max score of the right-right child" do
				node.right.right.updateMaxScores
				node.subRightMax.should eq node.right.right.scores[1]
			end
		end
	end

end