let { tap, hold, td, combo, encoder, macro, .. } = import "fak/keycode.ncl" in

# We alias commonly used stuff, so we don't end up repeating them over and over.
let kc = tap.reg.kc in
let me = tap.custom.media in
let XXXX = tap.none & hold.none in
let TTTT = tap.trans & hold.trans in
let tm = tap.reg.mod in
let md = hold.reg.mod in

# "cu" for custom keys. This is just a name, so it can be whatever you want.
let cu = {
  # Again, these are just names. They don't have to be 4-letter or capitalized.
  COPY = tm.lctl & kc.C,
  PSTE = tm.lctl & kc.V,
  SELALL =  tm.lctl & kc.A,
  UNDO = tm.lctl & kc.Z,
  REDO = tm.lctl & tm.lsft & kc.Z,

  COPYM = tm.lgui & kc.C,
  PSTEM= tm.lgui & kc.V,
  SELALLM =  tm.lgui & kc.A,
  UNDOM = tm.lgui & kc.Z,
  REDOM = tm.lgui & tm.lsft & kc.Z,
} in

# 1 tap = play/pause. 2 taps = next track. 3 taps = prev track.
let my_playback_tap_dance = td.make 400 [
  me.PLAY,
  me.NEXT,
  me.PREV,
  # Reminder: These can be hold-taps for more complex behavior.
  # These can even be tap dances... for nested tap dances... but uh... why though?
] in

let word_select = macro.make [
  macro.press md.lctl,
  macro.tap kc.RGHT,
  macro.tap kc.LEFT,
  macro.tap (kc.RGHT & tm.lsft),
  macro.release md.lctl,
] in

let word_select_m = macro.make [
  macro.press md.lalt,
  macro.tap kc.RGHT,
  macro.tap kc.LEFT,
  macro.tap (kc.RGHT & tm.lsft),
  macro.release md.lalt,
] in

let copy_all = macro.make [
  macro.press md.lctl,
  macro.tap kc.A,
  macro.tap kc.C,
  macro.release md.lctl,
] in

let copy_all_m = macro.make [
  macro.press md.lgui,
  macro.tap kc.A,
  macro.tap kc.C,
  macro.release md.lgui,
] in

let paste_all = macro.make [
  macro.press md.lctl,
  macro.tap kc.A,
  macro.tap kc.V,
  macro.release md.lctl,
] in

let paste_all_m = macro.make [
  macro.press md.lgui,
  macro.tap kc.A,
  macro.tap kc.V,
  macro.release md.lgui,
] in

# 1 tap = copy. 2 taps = copy all
let copy_copy_all = td.make 200 [
  cu.COPY,
  copy_all,
] in

let paste_paste_all = td.make 200 [
  cu.PSTE,
  paste_all,
] in

let select_select_all = td.make 200 [
  word_select,
  cu.SELALL,
] in

let copy_copy_all_m = td.make 200 [
  cu.COPYM,
  copy_all_m,
] in

let paste_paste_all_m = td.make 200 [
  cu.PSTEM,
  paste_all_m,
] in

let select_select_all_m = td.make 200 [
  word_select_m,
  cu.SELALLM,
] in


# Keymap definition
{
  virtual_keys = [

    # Combo activated by the third, fourth, and fifth physical keys
    # combo.make 69 [2, 3, 4],
    encoder.cw 0,
    encoder.ccw 0,
    combo.make 100 [0, 1, 2, 3],
    combo.make 100 [0, 1],
    combo.make 100 [0, 2],
  ],

  layers = [
    [ # Layer 0
      select_select_all, copy_copy_all, paste_paste_all, my_playback_tap_dance,

      # Combos start here in the same order we defined them above
      cu.UNDO,
      cu.REDO,
      tap.custom.fak.BOOT,
      tap.layer.DF 0,
      tap.layer.DF 1,
    ],
    [ # Layer 1
      select_select_all_m, copy_copy_all_m, paste_paste_all_m, TTTT,

      cu.UNDOM,
      cu.REDOM,
      TTTT,
      TTTT,
      TTTT,
    ],
  ]
}
