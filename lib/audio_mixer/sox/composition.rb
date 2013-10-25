require 'yaml'

module AudioMixer
  module Sox
    class Composition
      attr_reader :sounds

      def initialize(file)
        @file = file
        update!
      end

      def has_changed?
        @file.mtime != @last_mtime
      end

      def update!
        YAML.load(@file).tap do |collection|
          @sounds = collection if collection_is_valid?(collection)
        end

        @last_mtime = @file.mtime
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