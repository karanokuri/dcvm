Invoke-WebRequest http://downloads.dlang.org/releases/2.x/     |
    %{ $_.ParsedHtml.getElementById("content") }               |
    %{ $_.getElementsByTagName("li") }                         |
    %{ Write-Host "dmd.$($_.innerText)" }
