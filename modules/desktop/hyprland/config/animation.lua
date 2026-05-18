hl.curve("easeOutQuint", {
  type = "bezier",
  points = { { 0.22, 1 }, { 0.36, 1 } },
})

hl.animation({
  leaf = "global",
  enabled = true,
  speed = 3,
  bezier = "easeOutQuint",
})
