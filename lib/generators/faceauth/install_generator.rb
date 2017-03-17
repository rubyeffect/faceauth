module Faceauth
  module Generators

    class InstallGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Conschedule initializer and copy migration file to your application."

      def copy_initializer
        copy_file "initializer.rb", "config/initializers/faceauth.rb"
      end

      # def copy_migration
      #   run('rails faceauth:install:migrations')
      # end

      def show_readme
        readme "README"
      end 

    end
  end
end