# pi-b-q

Project to programatically interact with a Thermoworks BlueTherm thermomoter.

Today this thing (sort of) does:
* Can request and interpret data from the BlueTherm
* Assumes BT connection and serial port is managed externally

Someday this thing may (or may not):
* Automatically connect to any paired BT device
* Continuously record temperature data
* Provide a web interface to view recorded and near real-time data

## Installation on a Raspberry Pi
1. Start with a working, configured copy of Raspbian
1. ssh into the pi, `sudo mkdir -p /var/www`, `cd /var/www`, `sudo git clone <THIS REPO>`, `cd pi-b-q`
1. `sudo pi_config/install.sh`  This takes eons; go get a beer.
1. Make sure you've got a working Bluetooth adapter, then use hcitool and bluetooth-agent to pair your BT
1. Update /etc/bluetooth/rfcomm.conf to map the BT to /dev/rfcomm0
1. Restart the bluetooth stack: `sudo /etc/init.d/bluetooth restart`

Now you can pop open a rails console and send and receive packets!

1. `rvmsudo rails c` (use sudo because permissions are hard)
1. `serial = SerialPort.new('/dev/rfcomm0')`
1. `conn = BlueTherm::SerialConnection.new(serial)`
1. `response = conn.send(BlueTherm::Packet.default)`



## Some notes

### Pairing
* `hcitool scan` shows all bluetooth devices in range; use this to get ID
* `bluetooth-agent 1234 <ID>` should pair the device
