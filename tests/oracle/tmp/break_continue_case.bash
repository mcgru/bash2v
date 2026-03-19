i=0
while true; do
i=$((i + 1))
if [ "$i" -eq 2 ]; then
continue
fi
echo "$i"
if [ "$i" -eq 3 ]; then
break
fi
done