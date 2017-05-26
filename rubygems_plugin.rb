hook = lambda do |installer|
  if installer.spec.executables.any?
    system "rbenv", "rehash"
  end
end

shims_path = File.join(ENV['RBENV_ROOT'], "shims")
if File.writable?(shims_path)
  Gem.post_install(&hook)
  Gem.post_uninstall(&hook)
end
