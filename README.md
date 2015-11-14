# Shiro [![Circle CI](https://circleci.com/gh/pine613/Shiro/tree/master.svg?style=svg)](https://circleci.com/gh/pine613/Shiro/tree/master)

Shiro is the very cute Slack notification bot.

## Development environments

- [Crystal](http://crystal-lang.org/) v0.9.1
- [OpenShift](https://www.openshift.com/)

## Build & Test

```
$ crystal --version
Crystal 0.9.1 [b3b1223] (Fri Oct 30 03:31:36 UTC 2015)

$ make
$ make spec
```

## Commands

### `notify`
Notify mesage to Slack room

```
$ ./bin/notify --help
Usage: notify [arguments]
    --id ID                          Room ID
    --text TEXT                      Text
    -h, --help                       Show help

$ ./bin/notify --id ID --text TEXT
```

### `web_server`
Simple HTTP web server to keepalive OpenShift

```
$ PORT=8080 HOST=0.0.0.0 ./bin/web_server
```

### `connpass`
Connpass notification bot for staff. `connpass` command is called by Cron.

```
$ ./bin/connpass
```

### `qiita`
Qiita notification bot. `qiita` command is called by by Cron.

```
$ ./bin/qiita
```

## License

MIT License (MIT)

Copyright (c) 2015 Pine Mizune

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
