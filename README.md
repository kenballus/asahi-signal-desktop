# asahi-signal-desktop
A simple build+install script for Signal-Desktop on Asahi Linux

Should be easier to audit and understand than [prior work](https://github.com/BarbossHack/Signal-Desktop-Fedora).

## Usage
Just run the script, and pass the version number as the first argument.

For example, to install Signal v7.44.0, just run
```bash
./install_signal.sh 7.44.0
```

## WARNING
Signal-Desktop versions 7.45.0 and 7.45.1 don't launch on Asahi anymore. Either don't update, or don't use Signal-Desktop until a wokraround is available.
