# LESS.js for Windows
A simple command-line utilty for Windows that will compile `*.less` files to CSS using [less.js](https://github.com/cloudhead/less.js/).

[Original blog post](http://blog.dotsmart.net/2010/11/26/running-the-less-js-command-line-compiler-on-windows/).

## Usage
To use it, invoke lessc.wsf via cscript.exe like so:

    cscript //nologo lessc.wsf input.less [output.css] [-compress]

I've also added a less.cmd shim which will simplify it to just:

    lessc input.less [output.css] [-compress]
    
If you don't specify an output.css the result is written to standard output. The -compress option minifies the output. I'll look into implementing the other command-line arguments supported by lessc in due course.

I've added a couple of test files, so you can see if it's working like so:

    C:\code\lessc-wsh>lessc test/test.less
    /* Variables */
    #header {
      color: #4d926f;
    }
    h2 {
      color: #4d926f;
    }
    /* Mixins */
    #header {
      -moz-border-radius: 5px;
      -webkit-border-radius: 5px;
      border-radius: 5px;
    }
    ...
