use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'IP::Address',
    'VERSION_FROM' => 'Address.pm', # finds $VERSION
    'PREREQ_PM' => { 'Math::BigInt' => 0, },
);
