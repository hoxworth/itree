Dir[File.join(File.dirname(__FILE__),"itree","**","*.rb")].each do |file|
	require file
end