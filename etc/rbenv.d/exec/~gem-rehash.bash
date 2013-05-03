# Remember the current directory, then change to the plugin's root.
cwd="$PWD"
cd "${BASH_SOURCE%/*}/../../.."

# Make sure `rubygems_plugin.rb` is discovered by RubyGems by adding
# its directory to Ruby's load path.
export RUBYLIB="$PWD:$RUBYLIB"

cd "$cwd"
