# iocage-plugin-amule

a TrueNAS plugin for aMule **amuled** and **amuleweb** services.

## features

* port 4711 exposed (amuleweb)
* port 4712 exposed (amuled external connections)

## setup

Once the cage is running, you can connect to **http://cage-ip:4711** using a browser or to **cage-ip:4712** using `amulegui`.

The passwords are randomly generated, and can be found in the **/root/PLUGIN_INFO** file inside the cage. To show this file run: `iocage exec aMule cat /root/PLUGIN_INFO`

## license

Copyright (c) 2022, Davide Alberani.

Released under the terms of the BSD 3-Clause License.
