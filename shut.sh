#!/usr/bin/expect

# Defina as variáveis com as informações de login e o IP do switch
set switch_ip ""
set username ""
set password ""
set interface "GigabitEthernet10"

# Inicie uma sessão telnet com o switch
spawn telnet $switch_ip

# Aguarde o prompt de login e, em seguida, insira seu nome de usuário
expect "Username:"
send "$username\r"

# Aguarde o prompt de senha e, em seguida, insira sua senha
expect "Password:"
send "$password\r"

# Aguarde o prompt do switch (deve ser adaptado de acordo com o prompt real)
expect "CBS220>"

# Envie o comando para desligar a interface (substitua o comando conforme necessário)
send "configure terminal\r"
expect "CBS220(config)#"
send "interface $interface\r"
expect "CBS220(config-if)#"
send "shutdown\r"
expect "CBS220(config-if)#"

# Saia da sessão telnet
send "exit\r"
expect "CBS220>"

# Feche a sessão telnet
send "exit\r"
expect eof

# Eu usei esse script juntamente ao crontab em meu Linux Server
