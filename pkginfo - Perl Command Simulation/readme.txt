pkginfo Command User Manual - prepared by Tianpeng GOU, 12680373


1. To temporarily invoke 'pkginfo.pl' without './' or 'perl -w' at front, add pwd to PATH
  (In bash, execute: export PATH=$PATH:.)

2. The beginning of the program will check the length of arguments, validity of options and 
   whether the testing file can be opened successfully. (#1, #2, #3)

3. Next, each line of information will be split into 4 sections by requirement plus checking
   the format. If successful, all the split parts on each line will be stored in a matrix. 
   By doing this, the structure can be more clear, and avoid using multiple 'while(<>)' (#4)
   (Also, it is important that the 'empty' test file would not have any new line characters!!!) 

4. Then, the program will check if each split part would match the 'naming' requirement,
   two regular expression will be used. For the size, two compare operations will be implemented. (#5, #6)
   (The matching strategy is to recurringly match each character of 'name', and if the match number equals
    to the character number, then a successful match.)

5. Finally, all the options will be selectively invoked by user's choice. For '-l' option, if there's no 
   software name input, e.g. 'pkginfo.pl -l installed_software_file', then program will warn about the format.
   Other options will produce corresponding outputs specified by requirement only if the test file and its 
   content pass the initial format tests. (#7, #8, #9, #10)
