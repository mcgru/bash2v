VAR1=qweqwe
VAR1+="asdasd"
ARR1=()
ARR1+=( item1 item2 )
ARR1+=( it4 "it5 ooo" )
echo "${VAR1}|${ARR1[0]}|${ARR1[1]}|${ARR1[2]}|${ARR1[3]}|${#ARR1[@]}"