bluetooth_hook
================

The Bluetooth Hook is a web application which configures devices to fire web requests based on bluetooth visibility. Users can add and remove devices as well as specify endpoints and HTTP Request methods. Then, by running the application, endpoints will respond based on device proximity.

* [bluetooth_hook](https://github.com/ike18t/bluetooth_hook)

## Usage

* Clone the repository
* Go to project directory
* To use the web interface for adding/removing devices:
```
bundle exec rake start
```
* To run the application:
```
./bin/bluetooth_hook.rb
```