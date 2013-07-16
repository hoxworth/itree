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
		describe "#<=>" do
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