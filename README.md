# httpinfo

Display information about HTTP status codes.

Written in Abkhazia, Georgia 🇬🇪 2022-03-05.

## Installation

```bash
$ sudo curl -L "https://github.com/ABGEO/httpinfo/releases/download/v1.0.3/httpinfo.sh" -o /usr/local/bin/httpinfo
$ sudo chmod +x /usr/local/bin/httpinfo
```

## Usage

```console
$ httpinfo 200

200 OK
======

The HTTP 200 OK success status response code indicates that the request has succeeded. A 200 response is cacheable by default.

The meaning of a success depends on the HTTP request method:  GET: The resource has been fetched and is transmitted in the message body.  HEAD: The representation headers are included in the response without any message body  POST: The resource describing the result of the action is transmitted in the message body  TRACE: The message body contains the request message as received by the server.

The successful result of a PUT or a DELETE is often not a 200 OK but a 204 No Content (or a 201 Created when the resource is uploaded for the first time).


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Read more at: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/200
```

## Changelog

Please see [CHANGELOG](CHANGELOG.md) for details.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Authors

- [**Temuri Takalandze**](https://abgeo.dev) - *Maintainer*

## License

Copyright © 2022 [Temuri Takalandze](https://abgeo.dev).  
Released under the [GPLv3+](LICENSE) license.
