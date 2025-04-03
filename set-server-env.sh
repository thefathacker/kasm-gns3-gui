
# HOSTNAME VAR
if [ -z "${GNS3_HOST}" ]; then
  GNS3_HOST='gns3vm'
fi

if [ -z "${GNS3_USER}" ]; then
  GNS3_USER='gns3'
fi

if [ -z "${GNS3_PASS}" ]; then
  GNS3_USER='gns3'
fi

if [ -z "${GNS3_PORT}" ]; then
  GNS3_PORT='80'
fi

cat > /home/kasm-user/.config/GNS3/2.2/gns3_server.conf << EOF
[Server]
path = /usr/bin/gns3server
ubridge_path = ubridge
host = $GNS3_HOST
port = $GNS3_PORT
images_path = /home/kasm-user/GNS3/images
projects_path = /home/kasm-user/GNS3/projects
appliances_path = /home/kasm-user/GNS3/appliances
additional_images_paths =
symbols_path = /home/kasm-user/GNS3/symbols
configs_path = /home/kasm-user/GNS3/configs
report_errors = True
auto_start = False
allow_console_from_anywhere = False
auth = True
user = $GNS3_USER
password = $GNS3_PASS
protocol = http
console_start_port_range = 5000
console_end_port_range = 10000
udp_start_port_range = 10000
udp_end_port_range = 20000' 
EOF

chown 1000:0 /home/kasm-user/.config/GNS3/2.2/gns3_server.conf