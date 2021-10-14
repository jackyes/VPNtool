protonvpn status
echo
echo
echo
date
tm=$(protonvpn status | grep "Time:" | awk '$2 ~ /[0-9.]+/ { print $2 }' | cut -d ':' -f 1)
if [ $tm  -ge 1 ]; then
    echo "Time >= 1"
    echo More then 1h changing server
    protonvpn c -r
    while :
    do
        ld=$(protonvpn status | grep "Load:" | awk '$2 ~ /[0-9.]+/ { print $2 }' | sed 's/.$//')
        if [ $ld  -ge 70 ]; then
                echo "Load $ld % >= 70"
                echo Changing server...
                protonvpn c -r
        else
                break
        fi
    done
else
    while :
    do
        ld=$(protonvpn status | grep "Load:" | awk '$2 ~ /[0-9.]+/ { print $2 }' | sed 's/.$//')
        if [ $ld  -ge 70 ]; then
                echo "Load $ld % >= 70"
                echo Changing server...
                protonvpn c -r
        else
                break
        fi
        done
fi
