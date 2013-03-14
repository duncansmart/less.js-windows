# LESS.js for Windows

A standalone version of the [LESS](http://lesscss.org/) command-line compiler that will run on Windows with no other dependencies.

Consists of a standalone version of [Node.js](http://nodejs.org/) (compressed from 5 MB to 1.8 MB using [UPX](http://upx.sourceforge.net)) and the bare minimum less.js files. The whole package weighs in at just over 2 MB.


## Install

Either clone the repository or **[download and extract the latest ZIP](https://github.com/duncansmart/less.js-windows/archive/master.zip)** and invoke `lessc.cmd` as detailed below.


## Usage

Basic usage:

    lessc  path\source.less  path\output.css

Compress CSS:

    lessc  --yui-compress  path\source.less  path\output.css

For full usage:

    lessc -h


## History

Previously the project used the Windows Script Host `cscript.exe` as its runtime. Over time this was proving to be diffcult to support as it was essentially using the browser-based version of less.js and stubbing out objects like `window` and `document` to mimic the browser environment. This version is still available in the [windows-script-host](https://github.com/duncansmart/less.js-windows/tree/windows-script-host) branch.
