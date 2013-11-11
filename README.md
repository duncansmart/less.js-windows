# LESS.js for Windows

A standalone version of the [LESS](http://lesscss.org/) command-line compiler that will run on Windows with no other dependencies.

Consists of a standalone version of [Node.js](http://nodejs.org/) and the required less.js files/dependencies. 

## Install

**[Download and extract the release ZIP](https://github.com/duncansmart/less.js-windows/releases)** and invoke `lessc.cmd` as detailed below.

## Usage

Basic usage:

    lessc  path\source.less  path\output.css

Compress CSS:

    lessc  --clean-css  path\source.less  path\output.css

For full usage:

    lessc -h


## History

Previously the project used the Windows Script Host `cscript.exe` as its runtime. Over time this was proving to be diffcult to support as it was essentially using the browser-based version of less.js and stubbing out objects like `window` and `document` to mimic the browser environment. This version is still available in the [windows-script-host](https://github.com/duncansmart/less.js-windows/tree/windows-script-host) branch.
