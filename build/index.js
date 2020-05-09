const fs = require('fs')
const https = require('https')

// https://data.iana.org/TLD/tlds-alpha-by-domain.txt

const options = {
    hostname: 'data.iana.org',
    port: 443,
    path: '/TLD/tlds-alpha-by-domain.txt',
    method: 'GET'
}

const req = https.request(options, res => {
    let data = '';

    res.on('data', chunk => {
        data += chunk;
    })

    res.on('end', function () {
        const lines = data.split("\n").filter(line => {
            return !(line.includes("#") || line.includes("-") || line == "")
        });

        const content =
            `module TLDs exposing (list)

list : List String
list =
    [${lines.map(tld => ' "' + tld.toLowerCase() + '"')} ]
`

        fs.writeFile("../src/TLDs.elm", content, error => { });
    })
})

req.on('error', error => {
    console.error(error)
})

req.end()
