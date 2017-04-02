#"standard.h"


/*
 * draws a hex, up and to the right of origin
 * hex is 128 tall and 112 wide
 */
hex(s) {
  step(64,0)
  step(32,56)
  step(-32,56)
  step(-64,0)
  step(-32,-56)
  step(32,-56)
  s
}


flip(x) { eq(x,-1) ? 1 : -1 }

jitter { 0 | 8 | -8 | 16 | -16 | 32 | 48 | 64 | 52 | 0 }

even(x) {
  eq(x,mul(2,div(x,2)))
}
odd(x) {
  eq(1,even(x)) ? 0 : 1
}

/*
 * hexes - draw a field of hexes, w-wide and h-tall
 */
hexes(w, h) {
 
  set("hexes", 1)

  fori(1, h,

    !hexes
    for(1, w,
   --   print(cat(i,cat(",","y")))
      hex( rightsector(jitter, 256, 200))
      movestep(0,112) -- horizontal spacing
    )
    ^hexes
    movestep(96,mul(get("hexes"), 56)) -- vertical spacing
    set("hexes", mul(-1, get("hexes")))
  )

}

halfhex {
  step(128,0)
  step(-32,56)
  step(-64,0)
  step(-32,-56)
  rightsector(0, 256, 200)
}

caphex {
  step(0,112)
  step(-32,-56)
  step(32,-56)
  rightsector(0, 256, 200)
}

cornerhex {
  step(0,56)
  step(-32,0)
  step(32,-56)
  rightsector(0, 256, 200)
}

cornerhexNE {
  step(32,0)
  step(0,56)
  step(-32,-56)
  rightsector(0, 256, 200)
}

texrules {
  autotex("C", 0,    0, 0, "F_SKY1")
  autotex("F", 0,    0, 0, "MFLR8_2")
  autotex("F", 0,  984, 0, "SLIME01")
  autotex("F", 0,-1015, 0, "FLAT5_7")
  autotex("N", 0,    0, 0, "TANROCK5")
  autotex("L", 0,    0, 0, "TANROCK5")
}

main {
  !start

  texrules
  autotexall
thing
  
  ceil("F_SKY1")
  boxedhexes(32,32)

}

/*
 * a square field of hexes with a box border (width 64)
 * each hex adds 96 (128- overlap 32) height to the base 128
 */
boxedhexes(w,h) {
  !boxedhexes
  squarehexes(w,h)
  ^boxedhexes

  -- left
  movestep(-96,-64)
  box(128,256,200,    add(128 /* border */, add(128, mul(sub(h,1), 96))), 64)

  -- top
  movestep(add(64, add(128, mul(sub(h,1), 96))), 64)
  box(128,256,200,    64, add(56,mul(w,112)))

  -- bottom
  ^boxedhexes
  movestep(-96,0)
  box(128,256,200,    64, add(56,mul(w,112)))

  -- right
  ^boxedhexes
  movestep(-96,add(56,mul(w,112)))
  box(128,256,200,    add(128 /* border */, add(128, mul(sub(h,1), 96))), 64)
}

/*
 * hexes, but with a squared-off border
 * XXX: vary width to get back to 64 grid?
 * XXX: 1,1 looks odd
 */
squarehexes(w,h) {
  !squarehexes
  hexes(w,h)
  ^squarehexes

  -- left-hand side
  movestep(64,0)
  for(1,div(h,2),
    halfhex
    movestep(192,0)
  )

  -- top
  {odd(h) ? {
    cornerhexNE
    movestep(32,56)
    for(1,w,
      caphex
      movestep(0,112)
    )
  } : {
    movestep(-64,0)
    for(1,w,
      caphex
      movestep(0,112)
    )
    cornerhex
    movestep(-96,56)
  }}
 
  -- right-hand side
  turnaround
  for(1, even(h) ? div(h,2) : add(1,div(h,2)),
    halfhex
    movestep(192,0)
  )

  -- bottom
  movestep(-64,0)
  for(1,w,
  caphex
  movestep(0,112)
  )

  cornerhex
  turnaround
  movestep(32,-56) -- back to where we started
}
