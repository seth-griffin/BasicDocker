#!/bin/bash

/usr/sbin/mysqld&
/usr/sbin/apachectl -DFOREGROUND -k start
