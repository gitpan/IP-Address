##
## These are some sample incantations. Hope they help!
##
## lem@cantv.net - 19990712
##
#############
#############


use IP::Address qw($Always_Display_Mask $Use_CIDR_Notation);

$IP::Address::Always_Display_Mask = 0;
# $IP::Address::Use_CIDR_Notation = 0;

my $range = new IP::Address "161.196.0.0/17";
my $other = new IP::Address "200.44.0.0/30";
print "Subnet ", $range->to_string, " contains ", $range->how_many,
    " addresses\n";
print "Subnet ", $other->to_string, " contains ", $other->how_many,
    " addresses\n";

$range->set_mask($other);
$range->set_addr($other);
foreach $i ($range->enum) {
    print $i->to_string, " is part of ", $range->to_string, " with mask ",
    $i->mask_to_string, "\n";
}

my $first = new IP::Address "161.196.0.0/30";
my $middle = new IP::Address "161.196.0.4/30";
my $last = new IP::Address "161.196.0.8/30";
foreach $i ($first->range($middle, $last)) {
    print $i->to_string, " is between ", $first->to_string, " and ",
    $last->to_string, "\n";
}

my $big_ip = new IP::Address "200.44.0.0/17";
my $small_ip = new IP::Address "200.44.0.0/18";

print $small_ip->to_string, " is ", 
    $big_ip->contains($small_ip) ? '' : "not ",
    "contained in ". $big_ip->to_string, "\n";

my $big_ip = new IP::Address "200.44.0.0/18";
my $small_ip = new IP::Address "200.44.0.0/17";

print $small_ip->to_string, " is ", 
    $big_ip->contains($small_ip) ? '' : "not ",
    "contained in ". $big_ip->to_string, "\n";

my $big_ip = new IP::Address "161.196.0.0/23";
my $small_ip = new IP::Address "161.196.0.0/16";

print $small_ip->to_string, " is ", 
    $big_ip->contains($small_ip) ? '' : "not ",
    "contained in ". $big_ip->to_string, "\n";

my $ip = new IP::Address("10.0.0.1");
print "Address: ", $ip->to_string, "\n";
print "Network: ", $ip->network->to_string, "\n";
print "Broadcast: ", $ip->broadcast->to_string, "\n";
my $ip = new IP::Address("200.44.0.0/17");
print "Address: ", $ip->to_string, "\n";
print "Network: ", $ip->network->to_string, "\n";
print "Broadcast: ", $ip->broadcast->to_string, "\n";
my $ip = new IP::Address("200.44.32.19/255.255.255.252");
print "Address: ", $ip->to_string, "\n";
print "Network: ", $ip->network->to_string, "\n";
print "Broadcast: ", $ip->broadcast->to_string, "\n";
my $ip = new IP::Address("10.0.0.0/255.255.255.192");
print "Address: ", $ip->to_string, "\n";
print "Network: ", $ip->network->to_string, "\n";
print "Broadcast: ", $ip->broadcast->to_string, "\n";
my $ip = new IP::Address("0.0.0.0/0");
print "Address: ", $ip->to_string, "\n";
print "Network: ", $ip->network->to_string, "\n";
print "Broadcast: ", $ip->broadcast->to_string, "\n";


