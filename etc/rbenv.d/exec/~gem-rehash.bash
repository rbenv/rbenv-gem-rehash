# Remember the current directory, then change to the plugin's root.
cwd="$PWD"
cd "${BASH_SOURCE%/*}/../../.."

if [ "$2" != "./configure" ]; then
  # Make sure `rubygems_plugin.rb` is discovered by RubyGems by adding
  # its directory to Ruby's load path.
  export RUBYLIB="$PWD:$RUBYLIB"
fi

cd "$cwd"
