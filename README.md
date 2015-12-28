[![Build Status](https://travis-ci.org/ike18t/bluetooth_hook.svg)](https://travis-ci.org/ike18t/bluetooth_hook)
[![Code Climate](https://codeclimate.com/github/ike18t/bluetooth_hook/badges/gpa.svg)](https://codeclimate.com/github/ike18t/bluetooth_hook)
[![Test Coverage](https://codeclimate.com/github/ike18t/bluetooth_hook/badges/coverage.svg)](https://codeclimate.com/github/ike18t/bluetooth_hook/coverage)

##bluetooth_hook


The Bluetooth Hook is a web application which configures devices to fire web requests based on bluetooth visibility. Users can add and remove devices as well as specify endpoints and HTTP Request methods. Then, by running the application, endpoints will respond based on device proximity.

* [bluetooth_hook](https://github.com/ike18t/bluetooth_hook)

### Dependencies
* a linux box with bluetooth
* ruby
* hcitool
* root privileges (req'd by hcitool unfortunately)

### Usage

* Clone the repository and install dependent gems
* To run the application:
```
./bin/bluetooth_hook.rb
```
* To run the web interface for adding/removing devices:
```
./bin/bluetooth_web.rb
```
* Configure devices in the web interface running on port 4567

### Screenshots

##### Device List: #####
![device list](https://raw.githubusercontent.com/ike18t/bluetooth_hook/master/screenshots/list.png)

##### Add Device: #####
![add device](https://raw.githubusercontent.com/ike18t/bluetooth_hook/master/screenshots/add.png)


** Special thanks to [Manheim](www.manheim.com)'s Seller Tools team for allowing me and Rex to work on this during the team Hackathon.**