
use IP::Address;

print <<EOF;
	Basic IP conversion
EOF
    ;

$addr[0] = "10.1.2.3";
$addr[1] = "161.196.66.2";
$addr[2] = "200.44.32.12";
$addr[3] = "200.11.128.1";
$addr[4] = "224.16.5.172";
$addr[5] = "255.255.255.255";
$addr[6] = "0.0.0.0";

foreach $i (@addr) {

    $ip = IP::Address::_pack_address($i);
    print "* ", $i, " should be ", IP::Address::_unpack_address($ip), "\n" ;

}


print <<EOF;
	Basic Netmask Manipulation
EOF
    ;

$addr[0] = "255.255.255.255";
$addr[1] = "255.255.255.252";
$addr[2] = "255.255.0.0";
$addr[3] = "255.128.0.0";
$addr[4] = "255.255.192.0";
$addr[5] = "0.0.0.0";
$addr[6] = "255.255.255.224";

foreach $i (@addr) {

    $mask = IP::Address::_pack_address($i);
    $nomask = IP::Address::_negated_mask $mask;
    $bits = IP::Address::_mask_to_bits($mask);
    print "* ", $i, " is ", $bits, " wide and should be ",
  IP::Address::_unpack_address(IP::Address::_bits_to_mask($bits)),
    " (", IP::Address::_unpack_address($nomask), " negated)\n";

}


print <<EOF;
	Basic Data Type Operation
EOF
    ;

$addr[0] = "10.1.2.0/24";
$addr[1] = "161.196.66.2/255.255.255.128";
$addr[2] = "200.44.32.12/22";
$addr[3] = "200.11.128.1/17";
$addr[4] = "224.16.5.172/30";
$addr[5] = "10.128.10.11";
$addr[6] = "0.0.0.0/0";

foreach $i (@addr) {

    $ip = new IP::Address $i;
    print "* ", $i, " should be ", $ip->to_string, "(", $ip->addr_to_string,
    " / ", IP::Address::_unpack_address($ip->{'mask'}), ")\n" ;

}

print <<EOF;
	Subnet interpretation
EOF
    ;

foreach $i (@addr) {
    $ip = new IP::Address $i;
    print "* First in subnet ", $i, " is ", $ip->first->to_string, 
    ", last is ", $ip->last->to_string, "\n";

}

print <<EOF;
	Bitwise Mask Generation
EOF
    ;

foreach $bits (2, 8, 9, 16, 17, 18, 20, 22, 24, 27, 30, 32) {
    $mask = IP::Address::_bits_to_mask $bits;
    print $bits, " bits mask is ", IP::Address::_unpack_address($mask), "\n";
}

print <<EOF;
	Full Mask Generation
EOF
    ;

$addr[0] = "255.255.255.255";
$addr[1] = "255.255.255.252";
$addr[2] = "255.255.0.0";
$addr[3] = "255.128.0.0";
$addr[4] = "255.255.192.0";
$addr[5] = "0.0.0.0";
$addr[6] = "255.255.255.224";

foreach $i (@addr) {
    $mask = IP::Address::_pack_address $i;
    print IP::Address::_mask_to_bits($mask), " bits mask is ", 
    $i, "\n";
}


print <<EOF;
	Common Subnet Manipulation
EOF
    ;

$addr[0] = "10.1.2.0/28";
$addr[1] = "161.196.66.2/255.255.255.224";
$addr[2] = "200.44.32.14/30";
$addr[3] = "200.11.128.1/32";
$addr[4] = "224.16.5.172/30";
$addr[5] = "0.0.0.0/0";

foreach $i (@addr) {

    $ip = new IP::Address $i;
    print "* Address ", $ip->to_string, "(", $ip->how_many, 
    " hosts), broadcast ", 
    $ip->broadcast->to_string, 
    ", network ", $ip->network->to_string, "\n";

}

print <<EOF;
	Subnet expansion and ranges
EOF
    ;

$startnet[0] = "10.0.0.0/30";

$endnet[0] = "10.0.0.4/30";

foreach $i (0..$#startnet) {
    $subnet = new IP::Address($startnet[$i]);
    $endnet = new IP::Address($endnet[$i]);
    @subnet = $subnet->enum;
    @range = $subnet->range($endnet);
    print "Network ", $startnet[$i], ":\n";
    foreach $ip (@subnet) {
	print "   ", $ip->to_string, " belongs to it.\n";
    }
    print "Range from ", $startnet[$i], " to ", $endnet[$i], ":\n";
    foreach $ip (@range) {
	print "   ", $ip->to_string, " belongs to it.\n";
    }
}

print <<EOF;
	Subnet belonging
EOF
    ;

$subnet[0] = "200.44.0.0/17";
$subnet[1] = "161.196.66.0/24";
$subnet[2] = "10.128.0.0/8";
$subnet[3] = "255.255.255.255";
$subnet[4] = "0.0.0.0";
$subnet[5] = "0.0.0.0/0";

$ip[0] = "200.44.32.1";
$ip[1] = "10.5.4.3";
$ip[2] = "255.255.255.255";
$ip[3] = "0.0.0.0";
$ip[4] = "0.0.0.0/0";
$ip[5] = "161.196.66.2/30";
$ip[6] = "200.11.128.0";
$ip[7] = "200.44.0.1";
$ip[8] = "200.44.232.1";

foreach $subnet (@subnet) {
    my $m_subnet = new IP::Address $subnet;
    foreach $ip (@ip) {
	my $m_ip = new IP::Address $ip;
	print $ip, $m_subnet->contains($m_ip) ? " is contained " :
	    " is not contained ", "in ", $subnet, "\n";
    }
}
