#!/bin/bash

mkdir students

# We download file and remane it.

if [ ! -f "students/LCP_22-23_students.csv" ]; then
    wget "https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv" -O "students/LCP_22-23_students.csv";
else
    echo "File already exists";
fi

# Now we remove an unnecessary "log..." file that is created.

rm log*

cd students

grep "PoD" LCP_22-23_students.csv > PoD

grep "Physics" LCP_22-23_students.csv > Ph

# Since the students surnames are in the first column, we have to use:

for L in {A..Z}; do echo -n "$L: "; cut -d "," -f1 LCP_22-23_students.csv | grep -c "^$L"; done

# On where cut extracts columns (fields) from each line of a file.

# " -d "," " sets the delimiter to a comma because the file is a CSV (comma-separated values), this tells cut “columns are separated by commas”.

# "-f1" means "extract field (column) number 1".

max=0;
letter="";

for L in {A..Z}; do c=$(cut -d "," -f1 LCP_22-23_students.csv | grep -ci "^$L");
if [ $c -gt $max ];
then max=$c;
letter=$L;
fi;
done;

# "wc" gives number of lines, number of words, number of bytes and the file name. With -l we select only lines.

N=$(wc -l < LCP_22-23_students.csv) # "< LCP_22-23_students.csv" is used instead of just "LCP_22-23_students.csv" for taking just the number value.

# Code used:

for i in $(seq 2 $(wc -l < LCP_22-23_students.csv)); do g=$(( (i-2)%18+1 )); sed -n "${i}p" LCP_22-23_students.csv >> Group_$g; done

# "i" starts in 2 because 1st line is for titles.

# "g=$(( (i-2)%18+1 ))" uses 2 parenthesis becauses one is for the calculation and the second one to define it as a variable.

# "sed -n "${i}p" LCP_22-23_students.csv >> Group_$g" prints no line of LCP_22-23_students.csv unless "${i}p" line that is printed (included) in the file "Group_$g" that is automatically created if it does not exist.

# This overwrites the lists so if we want to make them again, we have to use " rm Group_* " to eliminate all the files named " Group_... ".
