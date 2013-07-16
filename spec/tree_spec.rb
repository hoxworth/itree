require 'spec_helper'

describe Intervals::Tree do
	let(:tree) { Intervals::Tree.new }

	context "creation" do
		describe "#initialize" do
			it { Intervals::Tree.new.size.should eq 0}
			it { Intervals::Tree.new.root.should be nil}
		end
	end

	describe "#insert" do
		context "tree is empty" do
			it "inserts a new node at root" do
				tree.insert(0,10,nil)
				tree.root.scores.should eq [0,10]
			end
		end

		context "inserting duplicates" do
			before(:each) { tree.insert(0,10,nil)}

			it { tree.insert(0,10,"taco").should be false}
			it "should not increase the size" do
				tree.insert(0,10,"taco")
				tree.size.should_not eq 2
			end
		end
	end

	describe "#remove" do

	end

	describe "#stab" do

	end
end