# Infraestrutura de rede com BGP Anycast, Consul Health Check, DNS e Web Apps usando containers!
Simular a configuração do Consul para o health check de dois servidores DNS e duas aplicações Apache usando containers incluindo na estrutura de projeto:

- Dois roteadores simulando anycast BGP usando o FRR

- Dois DNS usando dnsmasq.

- Usar httpd:alpine (ultima versão) para os webapps.

- Apontamentos DNS para todas as aplicações que possam ser acessadas via browser.

- Usar a rede: 192.168.8.0/21 como bridge:

```
network-infra/
├── docker-compose.yml
├── consul/
│   └── config/
│       ├── server.json
│       └── client.json
├── frr/
│   ├── router1/
│   │   ├── daemons
│   │   └── frr.conf
│   └── router2/
│       ├── daemons
│       └── frr.conf
├── dns/
│   ├── dnsmasq1/
│   │   └── dnsmasq.conf
│   └── dnsmasq2/
│       └── dnsmasq.conf
└── apache/
    └── httpd.conf
```