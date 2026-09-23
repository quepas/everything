# Find the latest compatible NVidia GPU driver

Script to figure out which is the latest NVidia GPU driver compatible with our graphics processor.
If you read closely the
On Ubuntu, there is `ubunut-drivers` which can figure this and install whatever is required if the network is up.
However, imagine you are preparing Ubuntu ISO for an offline unattended installation.
In such case, it is up to you to provide several installation packages and then select the apprioprate one.

It is worth mentioning a script created by Canonical https://github.com/canonical/ubuntu-drivers-common/blob/master/NvidiaDetector/nvidiadetector.py

## Using NVidiaDetector from Canonical/ubuntu-drivers-common

How to!

## Downloading databases of Vendor ID / Product ID

https://devicehunt.com/search/type/pci/vendor/10DE/device/any

https://www.pcilookup.com/?ven=10de&dev=&action=submit

In the Network tab of the Inspect Mode, look for the request:

GET /api.php?action=search&vendor=10de&device=&\_=1736968415367

There in the response, you will find the full set of NVidia products with their IDs.
