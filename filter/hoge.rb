#!/usr/bin/ruby

File.open('tmp', 'w') do |file|

  STDIN.each_line do |line|
    file.puts line
    STDOUT.puts line
  end

end
