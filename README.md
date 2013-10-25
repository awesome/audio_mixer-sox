# AudioMixer::Sox

Use AudioMixer::Sox to easily find and store the right balance of volume and panning for multiple sound files.

## Installation

First make sure you have [SoX][sox] installed on your machine. On Debian-based Linux distribution try:

[sox]: http://sox.sourceforge.net/

    $ sudo apt-get install sox

Then install this gem:

    $ gem install audio_mixer-sox

## Usage

    $ audio_mixer-sox [FILE]

Where `[FILE]` is a _YAML_ file of the following structure (only the `url` property is really necessary):

    # sample composition
    ---
    -
      url: "~/workspace/sounds/door_open.ogg"
      repeat: 1.2
      panning: 0.0
      volume: 1.0
      mute: false
    -
      url: "~/workspace/sounds/disappear.ogg"
      repeat: 1.5
      panning: 0.8
      volume: 1.0
      mute: false

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
