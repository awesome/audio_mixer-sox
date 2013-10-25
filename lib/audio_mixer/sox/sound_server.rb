module AudioMixer
  module Sox
    class SoundServer

      def initialize(composition)
        @composition = composition
        @sound_buffers = {}
        @timeouts = Hash.new(0)
      end

      def tick
        cache_sounds
        play_sounds
      end

      private

      def play_sounds
        Time.now.to_f.tap { |time| @delta_time, @last_time = time - (@last_time || time), time }

        (0..@composition.sounds.size-1).each do |index|
          sound = @composition.sounds[index]
          if (@timeouts[index] -= @delta_time) < 0
            @timeouts[index] = sound["repeat"] || 1.0
            play_sound(sound) unless sound["mute"]
          end
        end
      end

      def cache_sounds
        @composition.sounds.each do |sound|
          @sound_buffers[sound["url"]] ||= load_raw_sound(sound["url"])
        end
      end

      def load_raw_sound(url)
        IO.popen("sox #{File.expand_path(url)} -p", "rb") do |io|
          io.read
        end
      end

      def play_sound(sound)
        Thread.new do
          IO.popen("sox -v #{sound["volume"] || 1.0} -p -d pan #{sound["panning"] || 0.0} > /dev/null 2>&1", "wb") do |io|
            io.write(@sound_buffers[sound["url"]])
          end
        end
      end

    end
  end
end