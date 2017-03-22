module Faceauth
  module Generators
    class InstallGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates a Conschedule initializer and copy migration file to your application."

      #Method to generate a initializer configuration file with default configuration variables available.
      def copy_initializer
        copy_file "initializer.rb", "config/initializers/faceauth.rb"
      end

      #Method to read and display README document contents in terminal when generator is invoked.
      def show_readme
        readme "README"
      end 

    end
  end
end