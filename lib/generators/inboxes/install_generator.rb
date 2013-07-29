require 'rails/generators'
require 'rails/generators/migration'

module Inboxes
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      desc "Generates migration for Inboxes"

      def self.orm
        Rails::Generators.options[:rails][:orm]
      end

      def self.orm_has_migration?
        [:active_record].include? orm
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
          migration_number += 1
          migration_number.to_s
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def copy_migration
        migration_template 'install.rb', 'db/migrate/install_inboxes.rb'
      end

      # TODO
      # broken
      def mount_engine
        route "mount Inboxes::Engine => '/inboxes', :as => 'inboxes'"
      end
    end
  end
end
