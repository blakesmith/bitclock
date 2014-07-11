# Bitclock

![Bitclock](https://raw.github.com/blakesmith/bitclock/master/img/animated.gif)

This clock is hanging on the wall of clocks at the TempoIQ office in
Chicago. The clock represents a 64-bit UNIX timestamp with 64 LEDs,
with the least significant bit on the right hand side. The LED color
slowly changes from RGB {255, 127, 0} (Orange) to {0, 0, 255} (Blue)
throughout the day, starting at midnight UTC.

The LED strip is controlled via a small daemon written in haskell that
runs on a Raspberry Pi. The strip itself is a
[2 meter weatherproof LED strip](http://www.adafruit.com/products/306)
from Adafruit.

