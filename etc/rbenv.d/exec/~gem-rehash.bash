# rbenv-gem-rehash consists of two parts: a RubyGems plugin and an
# rbenv plugin.
#
# The RubyGems plugin hooks into the `gem install` and `gem uninstall`
# commands to run `rbenv rehash` afterwards, ensuring newly installed
# gem executables are visible to rbenv.
#
# The rbenv plugin (this file) is responsible for making the RubyGems
# plugin visible to RubyGems. It hooks into the `rbenv exec` command
# that rbenv's shims use to invoke Ruby programs. By appending the
# RubyGems plugin's location to the `GEM_PATH` environment variable,
# the hook ensures the RubyGems plugin is loaded for every invocation
# of Ruby across all installed versions.
#
# If the `GEM_PATH` environment variable is undefined,
# rbenv-gem-rehash must first execute the `gem env gempath` command
# to retrieve RubyGems' default path so that it can can *append* to
# the path rather than override it. This can take a while—from a few
# hundred milliseconds on MRI to several seconds on JRuby—so the
# default path for the current Ruby version is cached to the
# filesystem the first time it is retrieved.

# We set the `RBENV_GEM_REHASH` environment variable while running
# `gem env gempath` so that we avoid an infinite loop.
if [ -z "${RBENV_GEM_REHASH+undefined?}" ]; then
  # Remember the current directory, then change to the plugin's root.
  cwd="$PWD"
  cd "${BASH_SOURCE%/*}/../../.."

  # If `GEM_PATH` is undefined, we must load its default value.
  if [ -z "${GEM_PATH+undefined?}" ]; then
    cache_file="cache/$RBENV_VERSION"

    # Try to read it from the cache file, if it exists.
    if [ -f "$cache_file" ]; then
      GEM_PATH="$(cat "$cache_file")"

    # Otherwise, try to run `gem env gempath`. If it produces output,
    # extract the default path, load it into `GEM_PATH`, and write it
    # to the cache.
    else
      output="$(RBENV_GEM_REHASH=1 rbenv-exec gem env gempath 2>/dev/null || true)"
      if [ -n "$output" ]; then
        IFS=: default_gem_path=($output)
        GEM_PATH="${default_gem_path[1]}"
        echo "$GEM_PATH" > "$cache_file"
      fi
    fi
  fi

  # Append the plugin's root directory to `GEM_PATH` and change back
  # to the original directory.
  export GEM_PATH="${GEM_PATH}:$PWD"
  cd "$cwd"
fi
