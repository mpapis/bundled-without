module BundledWithout
  def add_bundled_with
  end
end

module BundlerDefinitionHack
  def require_relative(string)
    this_path, target_path = caller_locations(0, 2).map(&:absolute_path)

    # replace file path with `..` so we get to system root
    relative_path = this_path.gsub(%r"/[^/]+", "/..").sub(%r"^/", "")
    # remove file name from target file path - base of relative_require
    absolute_path = target_path.sub(%r"/[^/]+$", "/")
    # relative path from this file to the target file via system root
    relative_string = "#{relative_path}#{absolute_path}#{string}"

    # call the real relative_require
    result = super(relative_string)

    if string == "lockfile_generator"
      Bundler::LockfileGenerator.prepend(BundledWithout)
    end
    result
  end
end

Gem.execute do |original_file|
  # apply the hacks only when in bundler
  if %w[bundle bundler].include?(original_file.split('/').last)
    # hook into ruby require
    def require(path)
      # first call the real require
      result = super
      # bundler pre 2.1 uses require
      if result && path == "bundler/lockfile_generator"
        Bundler::LockfileGenerator.prepend(BundledWithout)
      end
      # bundler 2.1+ uses relative require
      if result && path == "bundler"
        Bundler.instance_exec do
          # force autoload and extend the class
          Bundler::Definition.prepend(BundlerDefinitionHack)
        end
      end
      result
    end
  end
end
