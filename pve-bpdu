tcpdump -lni vmbr0 -e -s 1600 \
'ether dst 01:80:c2:00:00:00 or ether dst 01:00:0c:cc:cc:cd' 2>/dev/null |
while IFS= read -r linha; do
    [[ "$linha" =~ ([0-9a-fA-F:]{17})[[:space:]]\>[[:space:]](01:80:c2:00:00:00|01:00:0c:cc:cc:cd) ]] || continue

    horario=$(awk '{print $1}' <<< "$linha")
    mac="${BASH_REMATCH[1]}"
    destino="${BASH_REMATCH[2]}"

    vlan=$(grep -oE 'vlan [0-9]+' <<< "$linha" | awk '{print $2}')
    [[ -z "$vlan" ]] && vlan="-"

    if [[ "$destino" == "01:00:0c:cc:cc:cd" ]]; then
        protocolo="Cisco PVST"
    else
        protocolo="STP/RSTP"
    fi

    arquivo=$(grep -Ril "$mac" \
        /etc/pve/qemu-server/ /etc/pve/lxc/ 2>/dev/null |
        head -n1)

    if [[ "$arquivo" =~ /qemu-server/([0-9]+)\.conf ]]; then
        origem="VM ${BASH_REMATCH[1]}"
    elif [[ "$arquivo" =~ /lxc/([0-9]+)\.conf ]]; then
        origem="CT ${BASH_REMATCH[1]}"
    else
        origem="Não identificado"
    fi

    printf '\033[1;36m%-15s\033[0m  '\
'\033[1;31m%-18s\033[0m  '\
'VLAN \033[1;33m%-5s\033[0m  '\
'%-12s  \033[1;32m%s\033[0m\n' \
        "$horario" "$mac" "$vlan" "$protocolo" "$origem"
done
