hook = lambda do |installer|
  if installer.spec.executables.any?
    system "rbenv", "rehash"
  end
end

Gem.post_install(&hook)
Gem.post_uninstall(&hook)
