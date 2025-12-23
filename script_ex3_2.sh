cp test/data.csv data.csv

# Now we make the copy we are asked for.

grep -v "^#" data.csv | sed -e "s/,//g" > data.txt

N=0; for x in $(grep -Eo "[0-9]+" data.txt); do if [ $x -ne 0 ] && [ $((x % 2)) -eq 0 ]; then N=$((N+1)); fi; done

echo "There are $N even numbers (excluding 0)."

G=0; S=0; E=0; R=$(echo "scale=6; 100/2 * sqrt(3)" | bc); for i in $(seq 1 $(wc -l < data.txt)); do row=$(sed -n "${i}p" data.txt| tr -d '\r'); x=$(echo "$row" | cut -d ' ' -f1); y=$(echo "$row" | cut -d ' ' -f2); z=$(echo "$row" | cut -d ' ' -f3); D=$(echo "scale=6; sqrt($x*$x + $y*$y + $z*$z)" | bc); if (( $(echo "$D > $R" | bc) )); then G=$((G+1)); elif (( $(echo "$D < $R" | bc) )); then S=$((S+1)); else E=$((E+1)); fi; done

for i in $(seq 1 $(wc -l < data.txt)); do row=$(sed -n "${i}p" data.txt| tr -d '\r'); x=$(echo "$row" | cut -d ' ' -f4); y=$(echo "$row" | cut -d ' ' -f5); z=$(echo "$row" | cut -d ' ' -f6); D=$(echo "scale=6; sqrt($x*$x + $y*$y + $z*$z)" | bc); if (( $(echo "$D > $R" | bc) )); then G=$((G+1)); elif (( $(echo "$D < $R" | bc) )); then S=$((S+1)); else E=$((E+1)); fi; done

echo "There are $G greater, $S smaller and $E equal entries."

for i in $(seq 2 $1); do > data_$i.txt; while read -r line; do new_line=""; for num in $line; do clean_num=$(echo "$num" | tr -d '\r'); new_num=$(echo "scale=6; $clean_num / $i" | bc); new_line="$new_line $new_num"; done; echo "$new_line" >> data_$i.txt; done < data.txt; done
