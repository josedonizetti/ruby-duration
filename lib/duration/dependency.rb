class Duration
  class Dependency
    LIBS = {
      'mongoid' => { :require => 'mongoid', :version => '~> 2.4.0' },
    }

    def self.load(name)
      begin
        gem(name, LIBS[name][:version])
        require(LIBS[name][:require])
      rescue LoadError
        abort <<-EOS
Dependency missing: #{name}
To install the gem, issue the following command:

    gem install #{name} -v '#{LIBS[name][:version]}'

Please try again after installing the missing dependency.
        EOS
      end
    end
  end
end
