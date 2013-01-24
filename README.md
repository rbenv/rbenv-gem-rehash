# rbenv-gem-rehash

**Never run `rbenv rehash` again.** rbenv-gem-rehash is an rbenv
plugin that automatically runs `rbenv rehash` when you install or
uninstall a gem.

## Installation

    git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

## Usage

1. `gem install` a gem that provides executables.
2. Marvel at how you no longer need to type `rbenv rehash`.

## How It Works

rbenv-gem-rehash consists of two parts: a RubyGems plugin and an rbenv
plugin.

The RubyGems plugin hooks into the `gem install` and `gem uninstall`
commands to run `rbenv rehash` afterwards, ensuring newly installed
gem executables are visible to rbenv.

The rbenv plugin is responsible for making the RubyGems plugin visible
to RubyGems. It hooks into the `rbenv exec` command that rbenv's shims
use to invoke Ruby programs. By appending the RubyGems plugin's
location to the `GEM_PATH` environment variable, the hook ensures the
RubyGems plugin is loaded for every invocation of Ruby across all
installed versions.

## Caveats

If the `GEM_PATH` environment variable is undefined, rbenv-gem-rehash
must first execute the `gem env gempath` command to retrieve RubyGems'
default path so that it can can *append* to the path rather than
override it. This can take several seconds, so the default path for
the current Ruby version is cached to the filesystem the first time it
is retrieved.

## License

(The MIT License)

Copyright (c) 2013 Sam Stephenson <<sstephenson@gmail.com>>

Copyright (c) 2013 Joshua Peek <<josh@joshpeek.com>>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
