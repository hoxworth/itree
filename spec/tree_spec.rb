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
		context "insert node in empty tree" do
			it "inserts at root" do
				tree.insert(0,10)
				tree.root.scores.should eq [0,10]
			end

			it "increases tree size" do
				tree.insert(0,10)
				tree.size.should eq 1
			end
		end

		context "inserting duplicates" do
			before(:each) { tree.insert(0,10)}

			it { tree.insert(0,10,"taco").should_not be true}
			it "does not increase tree size" do
				tree.insert(0,10,"taco")
				tree.size.should_not eq 2
			end
		end

		context "rotations" do
			before(:each) do
				tree.insert(150,250)
				tree.insert(200,300)
				tree.insert(100,200)
			end

			it { tree.root.scores.should eq [150,250] }
			it { tree.root.left.scores.should eq [100,200] }
			it { tree.root.right.scores.should eq [200,300] }
			it { tree.size.should eq 3 }

			context "left-left rotation" do
				before(:each) do
					tree.insert(25,50)
					tree.insert(0,25)
				end

				it "does not change root" do
					tree.root.scores.should eq [150,250]
				end
				it { tree.root.left.scores.should eq [25,50] }
				it { tree.root.left.left.scores.should eq [0,25] }
				it { tree.root.left.right.scores.should eq [100,200] }
				it { tree.root.subLeftMax.should eq 200 }
			end

			context "right-right rotation" do
				before(:each) do
					tree.insert(250,300)
					tree.insert(300,350)
				end

				it "does not change root" do
					tree.root.scores.should eq [150,250]
				end
				it { tree.root.right.scores.should eq [250,300] }
				it { tree.root.right.left.scores.should eq [200,300] }
				it { tree.root.right.right.scores.should eq [300,350] }
				it { tree.root.subRightMax.should eq 350 }
			end

			context "left-right rotation" do
				before(:each) do
					tree.insert(50,100)
					tree.insert(75,125)
				end

				it "does not change root" do
					tree.root.scores.should eq [150,250]
				end
				it { tree.root.left.scores.should eq [75,125] }
				it { tree.root.left.left.scores.should eq [50,100] }
				it { tree.root.left.right.scores.should eq [100,200] }
				it { tree.root.subLeftMax.should eq 200 }
			end

			context "right-left rotation" do
				before(:each) do
					tree.insert(250,300)
					tree.insert(225,275)
				end

				it "does not change root" do
					tree.root.scores.should eq [150,250]
				end
				it { tree.root.right.scores.should eq [225,275] }
				it { tree.root.right.left.scores.should eq [200,300] }
				it { tree.root.right.right.scores.should eq [250,300] }
				it { tree.root.subRightMax.should eq 300 }
			end
		end

	end

	describe "#insert!" do
		context "inserting duplicates" do
			before(:each) { tree.insert(0,10,"cheese")}

			it { tree.root.data.should eq "cheese" }
			it { tree.insert!(0,10,"taco").should_not be true}
			it "does not increase tree size" do
				tree.insert!(0,10,"taco")
				tree.size.should_not eq 2
			end
			it "updates the node data" do
				tree.insert!(0,10,"taco")
				tree.root.data.should eq "taco"
			end
		end
	end

	describe "#remove" do

	end

	describe "#stab" do

	end
end