// httpget.js: download a file (Windows Script Host)
// usage: cscript httpget.js <url> <file>
// https://gist.github.com/duncansmart/5821523

(function() {    
    if (WScript.Arguments.Length != 2) {
        WScript.Echo("Usage: httpget.js <url> <file>")
        WScript.Quit(1)
    }
        
    var url = WScript.Arguments(0)
    var filepath = WScript.Arguments(1)

    var xhr = new ActiveXObject("MSXML2.XMLHTTP")

    xhr.open("GET", url, false)
    xhr.send()

    if (xhr.Status == 200) {

        var fso = new ActiveXObject("Scripting.FileSystemObject")
        if (fso.FileExists(filepath))
            fso.DeleteFile(filepath)
        
        var stream = new ActiveXObject("ADODB.Stream")
        stream.Open()
        stream.Type = 1 //adTypeBinary
        stream.Write(xhr.ResponseBody)
        stream.Position = 0        
        stream.SaveToFile(filepath)
        stream.Close()
    }
    else {
        WScript.Echo("Error: HTTP " + xhr.status + " "+ xhr.statusText)
    }
})();
