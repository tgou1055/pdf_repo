#!/usr/bin/perl -w

### Unix System Programming
### Final Assignmemt - Spring, 2017
### Tianpeng Gou, 12680373


#1. Verify the size of @ARGV.
$length = scalar( @ARGV ) ;
if ( $length < 1 ) {
    die "Wrong command input - lack of either <option> or <filename>\n";
} elsif ( $length > 3 ){
    die "Wrong command input - too many arguments\n"
}

#2. Verify 'option'
$option = $ARGV[0];
if ( $option =~ m/^-[aslv]\b/ ){} else {die "Invalid command syntax\n"}


#10 <option> -v :  firstname, surname - sid
if ($option eq "-v"){
    die "Tianpeng, GOU - 12680373\n";
    
}

#3. Verify INFILE
$last_index = $length - 1;
(-e "$ARGV[$last_index]") || die "File is not existed\n";
(-r "$ARGV[$last_index]") || die "File is not readable\n";
open (INFILE, $ARGV[$last_index]) || die "File opening error\n";

#4. Verfify file format
$count = 0;
@matrix = (); # store info in a matrix: more efficient
while (<INFILE>){
    chomp;
    @info = split( /\,/, $_ );
    if (scalar(@info) < 4 && scalar(@info) > 0) {
        die "Each line must contain four fields seperated by comma\n";
    }
    push ( @{$matrix[$count]}, @info) ;
    $count ++;
};
$info_size = scalar(@info) ;

#5. Define regexp for info
$reg_cn = "[A-Za-z0-9_.]";
$reg_de = "[A-Za-z0-9_.+-/ ]";

#6. Check RegExp
$match = 0;

for ($i = 0; $i < $count ; $i ++){
    for ($j = 0; $j < $info_size ; $j ++){
        $temp = $matrix[$i][$j];
        $string_length = length ($temp);        
        if ($j == 0 || $j == 1) {
            #print "string length: " . "$string_length" . "\n";
            while( $temp =~ m/$reg_cn/g ){
                $match ++;                
            }
            #print "matches:" . "$count1" . "\n";
            if ($string_length != $match) {die "Wrong category or name format\n";}
            $match = 0;
        } elsif ($j == 2){
            while( $temp =~ m/$reg_de/g ){
                $match ++;
            } 
            if ($string_length != $match ) {die "Wrong description format\n";}
            $match = 0;
        } else {
            if ( $temp >= 1 && $temp <= 10000000 ){
            } else {
                die "Wrong file size\n";
            }
        }
    }
}


#7 <option> -a : Installed software names
if ($option eq "-a" && $length == 2){
    if ($count == 0){die "No software installed\n";}
    print "Installed software:\n";
    for ($i = 0; $i < $count ; $i ++){
        $temp = $matrix[$i][1];
        print $temp . "\n";
    }
} elsif ($option eq "-a" && $length != 2){
    print "modify command input:\npkginfo.pl -a <filename>\n";
}

#8 <option> -s : Sum total size
if ($option eq "-s" && $length == 2){
    if ($count == 0){die "Total size in kilobytes: 0\n";}
    $sum = 0;
    for ($i = 0; $i < $count ; $i ++){
        $temp = $matrix[$i][3];
        $sum += $temp;
    }
    print "Total size in kilobytes: $sum \n";
} elsif ($option eq "-s" && $length != 2){
    print "modify command input:\npkginfo.pl -s <filename>\n";
}


#9 <option> -l <name> :Print info for single software
$trigger = 0;
if ($option eq "-l" && $length == 3){
    for ($i = 0; $i < $count ; $i ++){
        $temp = $matrix[$i][1];
        if ($temp eq "$ARGV[1]"){  # case sensitive
            print "Package $ARGV[1]:\n";
            print "Category: $matrix[$i][0]\n";
            print "Description: $matrix[$i][2]\n";
            print "Size in kilobytes: $matrix[$i][3]\n";
            $trigger = 1;
         }
    }
    if ($trigger == 0){print "No installed package with this name\n";}
} elsif ($option eq "-l" && $length != 3){
    print "modify command input:\npkginfo.pl -l <softwarename> <filename>\n";
}
