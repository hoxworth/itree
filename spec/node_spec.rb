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

	end

end