

#### Count the number of lines in a (txt) file

`(gc [the_file.txt]).Count`


#### list the content of a directory and grep for a substring

`ls some_dir |  ? { $_.Name -like "*some_string*" }
