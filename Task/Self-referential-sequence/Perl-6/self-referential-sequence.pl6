my @list;
my $longest = 0;
my %seen;

for 1 .. 1000000 -> $m {
    next unless $m ~~ /0/;         # seed must have a zero
    my $j = join '', $m.comb.sort;
    next if %seen.exists($j);      # already tested a permutation
    %seen{$j} = '';
    my @seq := converging($m);
    my %elems;
    my $count;
    for @seq[] -> $value { last if ++%elems{$value} == 2; $count++; };
    if $longest == $count {
        @list.push($m);
        say "\b" x 20, "$count, $m"; # monitor progress
    }
    elsif $longest < $count {
        $longest = $count;
        @list = $m;
        say "\b" x 20, "$count, $m"; # monitor progress
    }
};

for @list -> $m {
    say "Seed Value(s): ", ~permutations($m).uniq.grep( { .substr(0,1) != 0 } );
    my @seq := converging($m);
    my %elems;
    my $count;
    for @seq[] -> $value { last if ++%elems{$value} == 2; $count++; };
    say "\nIterations: ", $count;
    say "\nSequence: (Only one shown per permutation group.)";
   .say for @seq[^$count], "\n";
}

sub converging ($seed) { return $seed, -> $l { join '', map { $_.value.elems~$_.key }, $l.comb.classify({$^b}).sort: {-$^c.key} } ... * }

sub permutations ($string, $sofar? = '' ) {
    return $sofar unless $string.chars;
    my @perms;
    for ^$string.chars -> $idx {
        my $this = $string.substr(0,$idx)~$string.substr($idx+1);
        my $char = substr($string, $idx,1);
        @perms.push( permutations( $this, join '', $sofar, $char ) ) ;
    }
    return @perms;
}
