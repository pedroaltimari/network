#!/usr/bin/expect

set switch_ip ""
set username ""
set password ""
set interface "GigabitEthernet10"

# Conexão TELNET
spawn telnet $switch_ip

# Insira seu usuário
expect "Username:"
send "$username\r"

# Insira sua senha
expect "Password:"
send "$password\r"

# Aguardo do prompt do switch
expect "CBS220>"

send "configure terminal\r"
expect "CBS220(config)#"
send "interface $interface\r"
expect "CBS220(config-if)#"
send "shutdown\r"
expect "CBS220(config-if)#"

# Desconexão TELNET
send "exit\r"
expect "CBS220>"
send "exit\r"
expect eof

# Utilizei este script junto ao crontab para fins de automação na minha infra
