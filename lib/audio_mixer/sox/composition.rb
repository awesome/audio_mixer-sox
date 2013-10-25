require 'yaml'

module AudioMixer
  module Sox
    class Composition
      attr_reader :sounds

      def initialize(filename)
        @filename = filename
        update!
      end

      def has_changed?
        File.new(@filename, "r").mtime > @last_mtime
      rescue Errno::ENOENT
        puts "Composition file unavailable!"
      end

      def update!
        YAML.load_file(@filename).tap do |collection|
          if collection_is_valid?(collection)
            @sounds = collection
            puts "Composition file updated..."
          end
        end
      rescue Psych::SyntaxError
        puts "Composition file corrupted, ignoring..."
      ensure
        @last_mtime = Time.now
      end

      private

      def collection_is_valid?(collection)
        collection.is_a?(Enumerable) && collection.all? { |sound| sound_is_valid?(sound) }
      end

      def sound_is_valid?(sound)
        sound.respond_to?(:[]) && sound["url"] != nil && File.exists?(File.expand_path(sound["url"]))
      end

    end
  end
end