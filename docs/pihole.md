# Pihole DNS

Pi-hole is a Linux network-level advertisement and Internet tracker blocking application which acts as a DNS sinkhole and optionally a DHCP server, intended for use on a private network. It is designed for low-power embedded devices with network capability, such as the Raspberry Pi, but supports any Linux machines.

[Wikipedia](https://https://en.wikipedia.org/wiki/Pi-hole)

## Specs


| Service | Pihole                           |
| :-------- | :--------------------------------- |
| TYPE    | Docker Container                 |
| HOST    | captain                          |
| IP      | 192.168.50.4                     |
| OS      | dockerhub pihole/pihole          |
| CPU     | no restrictions                  |
| RAM     | no restrictions                  |
| Disk    | volume: /hdd-pool/appdata/pihole |

## Deploying

```bash
ansible-playbook  virtual-servers/pihole.yml -i ansible/inventory.yml --extra-vars "user=$CAPTAIN_USER"
```

After the container creation log into it and change the admin passowrd.

```bash
ssh captain.psilva.org
docker exec -it pihole bash
pihole -a -p
```

## DNS RECORDS


| servername           | host    | type     | IP             |
| :--------------------- | :-------- | ---------- | :--------------- |
| bob.psilva.org       |         | physical | 192.168.50.172 |
| captain.psilva.org   |         | physical | 192.168.50.220 |
| jenkins.psilva.org   | captain | docker   | 192.168.50.9   |
| pihole.psilva.org    | captain | docker   | 192.168.50.4   |
| plex.psilva.org      | captain | docker   | 192.168.50.6   |
| speedtest.psilva.org | captain | docker   | 192.168.50.8   |
| vault1.psilva.org    | captain | docker   | 192.168.50.11  |

## Backup Plan

Backup the folder `captain.psilva.org:/hdd-pool/appdata/jenkins`
