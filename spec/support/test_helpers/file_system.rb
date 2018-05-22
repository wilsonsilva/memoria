module TestHelpers
  module FileSystem
    # Create a temporary file.
    def self.create_file(directory, name)
      file_path = File.join(directory, name) + '.snap'
      File.open(file_path, 'w') { |f| f.write('initial') }
    end

    # Create a temporary directory.
    def self.create_directory
      path = Dir.mktmpdir('memoria-temporary-test-dir')
      ensure_cleanup(path)
      path
    end

    # Delete temporary files and directories created during tests.
    def self.teardown
      directories.each { |path| FileUtils.remove_entry_secure(path) }
      directories.clear
    end

    def self.directories
      @directories ||= []
    end

    # Registers the given +path+ to be deleted when #teardown is called.
    def self.ensure_cleanup(path)
      directories << path
    end
  end
end
