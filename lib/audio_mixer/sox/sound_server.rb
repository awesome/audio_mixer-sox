module AudioMixer
  module Sox
    class SoundServer

      def initialize(composition)
        @composition = composition
        @sound_buffers = {}
        @timeouts = Hash.new(0)
      end

      def update!
        cache_sounds
        play_sounds
      end

      private

      def play_sounds
        deltaTime = Time.now.to_f - (@lastTime || Time.now.to_f)
        @lastTime = Time.now.to_f

        (0..@composition.sounds.size-1).each do |index|
          @timeouts[index] -= deltaTime

          if @timeouts[index] < 0
            @timeouts[index] = @composition.sounds[index]["timeout"] || 1.0
            play_sound(@composition.sounds[index])
          end
        end
      end

      def cache_sounds
        (0..@composition.sounds.size-1).each do |index|
          url = @composition.sounds[index]["url"]
          @sound_buffers[url] ||= load_raw_sound(url)
        end
      end

      def load_raw_sound(url)
        process = IO.popen("sox #{File.expand_path(url)} -p", "rb") do |io|
          io.read
        end
      end

      def play_sound(sound)
        Thread.new do
          process = IO.popen("sox -v #{sound["volume"] || 1.0} -p -d pan #{sound["panning"] || 0.0} > /dev/null 2>&1", "wb") do |io|
            io.write(@sound_buffers[sound["url"]])
          end
        end
      end

    end
  end
end