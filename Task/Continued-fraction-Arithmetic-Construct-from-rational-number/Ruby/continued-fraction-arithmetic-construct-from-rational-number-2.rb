[[1,2], [3,1], [23,8], [13,11], [22,7], [-151,77]].each do |n1,n2|
  print "%10s : " % "#{n1} / #{n2}"
  r2cf(n1,n2) {|n| print "#{n} "}
  puts
end
