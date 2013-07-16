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
		end
	end

	describe "#insert" do
	end

	describe "#resetBalance" do
	end

	describe "#updateMaxScores" do

	end

end