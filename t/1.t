# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..5\n"; }
END {print "not ok 1\n" unless $loaded;}
use IP::Address;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

my $big_ip = new IP::Address "200.44.0.0/17";
my $small_ip = new IP::Address "200.44.0.0/18";

print ($big_ip->contains($small_ip) ? "ok 2\n" : "not ok 2\n");
print ($small_ip->contains($big_ip) ? "not ok 3\n" : "ok 3\n");

if ($big_ip->broadcast->addr_to_string eq "200.44.127.255") {
    print "ok 4\n";
}
else {
    print "not ok 4\n";
}

if ($big_ip->how_many != 32768) {
    print "not ok 5\n";
}
else {
    print "ok 5\n";
}

exit 0;
