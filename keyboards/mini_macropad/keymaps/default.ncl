let { tap, hold, td, combo, encoder, .. } = import "fak/keycode.ncl" in

# We alias commonly used stuff, so we don't end up repeating them over and over.
let kc = tap.reg.kc in
let me = tap.custom.media in
let XXXX = tap.none & hold.none in
let TTTT = tap.trans & hold.trans in

# "cu" for custom keys. This is just a name, so it can be whatever you want.
let cu = {
  # Again, these are just names. They don't have to be 4-letter or capitalized.
  COPY = tap.reg.mod.lgui & kc.C,
  PSTE = tap.reg.mod.lgui & kc.V,
  SELALL =  tap.reg.mod.lgui & kc.A,

  # Screenshot
  SCSH = tap.reg.mod.lgui & tap.reg.mod.lsft & kc.S,
} in

# 1 tap = play/pause. 2 taps = next track. 3 taps = prev track.
let my_playback_tap_dance = td.make 200 [
  me.PLAY,
  me.NEXT,
  me.PREV,
  # Reminder: These can be hold-taps for more complex behavior.
  # These can even be tap dances... for nested tap dances... but uh... why though?
] in

# Keymap definition
{
  virtual_keys = [
    # Combo activated by the first and second physical keys
    # combo.make 42 [0, 1],

    # Combo activated by the third, fourth, and fifth physical keys
    # combo.make 69 [2, 3, 4],
    encoder.cw 0,
    encoder.ccw 0,
    combo.make 50 [0, 1, 2, 3]
  ],

  layers = [
    [ # Layer 0
      cu.SELALL, cu.COPY, cu.PSTE, my_playback_tap_dance,

      # Combos start here in the same order we defined them above
      me.VOLD,
      me.VOLU,
      tap.custom.fak.BOOT,
    ],
    [ # Layer 1
      kc.A,    kc.B,    kc.C, kc.D,

      TTTT,
      TTTT,
      TTTT,
    ],
    [ # Layer 2
      kc.N7,   kc.N8,   kc.N9, kc.D,

      TTTT,
      TTTT,
      TTTT,
    ],
  ]
}
