README
======

Note: This is a fork of Derick Rethans' VLD. Development and testing were conducted on an Ubuntu 20.04 LTS x86_64 **GNU/Linux** machine against PHP 5.4.16 and a SourceGuardian 11.4 loader. 
The source code changes are based on the `'last-for-php5'` tag from the VLD project. 
The assembly code is very specific to the SourceGuardian 5.4 loader.

As with the original VLD, this extension is designed to show low level PHP structures. It is therefore very
sensitive to changes in the PHP API. However, this fork has a new option, 'sg_decode' which will hook 
zend_execute() and dump opcodes protected by SourceGuardian. 

**Attention**: 

  `The code does not support compiling under windows`


Clone and Build:
----------------
git clone https://github.com/tyonly/vld-sourceguardian.git

cd vld-sourceguardian

phpize && ./configure && make && sudo make install

Example Usage:
--------------

php -dvld.active=1 -dvld.execute=0 -dvld.sg_decode=1 -dvld.dump_paths=0 file.php

Troubleshooting:
----------------
No output? Ensure vld is enabled in php.ini.

How does it work?
-----------------

Please see the project page at http://derickrethans.nl/projects.html#vld for
some more information on the original project. More info to come.

