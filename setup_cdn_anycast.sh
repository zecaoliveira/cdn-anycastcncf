#!/bin/bash

# Criação da estrutura de diretórios
mkdir -p cdn-anycast-sim/{consul,bird,dnsmasq,apache/app01,apache/app02}

# Criação do arquivo docker-compose.yml com conteúdo inicial
cat <<EOF > cdn-anycast-sim/docker-compose.yml
version: '3.8'

services:
# Serviços DNS, BGP, Consul e Apache serão configurados aqui
# Este arquivo será completado com os detalhes de configuração dos serviços
EOF

# Criação dos arquivos consul-config.json e consul-client-config.json
cat <<EOF > cdn-anycast-sim/consul/consul-config.json
{
"service": {
    "name": "cdn-anycast",
    "tags": ["anycast"],
    "port": 8500,
    "check": {
    "http": "http://localhost:8500/v1/health/service/cdn-anycast",
    "interval": "10s"
    }
}
}
EOF

cat <<EOF > cdn-anycast-sim/consul/consul-client-config.json
{
"service": {
    "name": "cdn-anycast-client",
    "tags": ["client"]
}
}
EOF

# Criação dos arquivos de configuração do BIRD (bird1.conf e bird2.conf)
cat <<EOF > cdn-anycast-sim/bird/bird1.conf
router id 192.168.30.10;

protocol kernel {
    scan time 20;
    import all;
    export all;
}

protocol device {
    scan time 10;
}

protocol direct {
    interface "eth0";
}

protocol bgp {
    local as 65001;
    neighbor 192.168.30.11 as 65001;
    import all;
    export where net = 192.168.40.10/32;
}

protocol static {
    route 192.168.40.10/32 via "eth0";
}
EOF

cat <<EOF > cdn-anycast-sim/bird/bird2.conf
router id 192.168.30.11;

protocol kernel {
    scan time 20;
    import all;
    export all;
}

protocol device {
    scan time 10;
}

protocol direct {
    interface "eth0";
}

protocol bgp {
    local as 65001;
    neighbor 192.168.30.10 as 65001;
    import all;
    export where net = 192.168.40.11/32;
}

protocol static {
    route 192.168.40.11/32 via "eth0";
}
EOF

# Criação dos arquivos de configuração do dnsmasq (dnsmasq1.conf e dnsmasq2.conf)
cat <<EOF > cdn-anycast-sim/dnsmasq/dnsmasq1.conf
address=/app.cdn/192.168.40.10
address=/app.cdn/192.168.40.11
EOF

cat <<EOF > cdn-anycast-sim/dnsmasq/dnsmasq2.conf
address=/app.cdn/192.168.40.10
address=/app.cdn/192.168.40.11
EOF

# Criação dos arquivos HTML das aplicações (index.html para app01 e app02)
cat <<EOF > cdn-anycast-sim/apache/app01/index.html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>App01</title>
</head>
<body>
    <h1>Você está acessando a aplicação no servidor App01</h1>
</body>
</html>
EOF

cat <<EOF > cdn-anycast-sim/apache/app02/index.html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>App02</title>
</head>
<body>
    <h1>Você está acessando a aplicação no servidor App02</h1>
</body>
</html>
EOF

# Mensagem de conclusão
echo "Estrutura do projeto 'cdn-anycast-sim' criada com sucesso!"

