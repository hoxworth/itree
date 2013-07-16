require 'spec_helper'

describe Intervals::Tree do
	context "creation" do
		describe "#initialize" do
			it { Intervals::Tree.new.size.should eq 0}
			it { Intervals::Tree.new.root.should be nil}
		end
	end
end