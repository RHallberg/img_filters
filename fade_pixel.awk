BEGIN {
  MAX_COLOR = 65535
}
function to_dec(v)
{
  return sprintf("%d", "0x" v)
}

function clamp(v)
{
  if (v < 0)      return 0
  if (v > MAX_COLOR) return MAX_COLOR
  return int(v)
}

NR == 1 {
  gsub(" ", "")
  print; next}
NR == 2 {
  WIDTH = to_dec($1 $2)
  HEIGHT = to_dec($3 $4)
  p_fact = 1 / (HEIGHT * WIDTH)
  gsub(" ", "")
  printf("%08x%08x", WIDTH, HEIGHT)
  next
}

# VARIABLES
{
  red   = to_dec($1)
  green = to_dec($2)
  blue  = to_dec($3)
  alpha = to_dec($4)

  pixel  = NR - 2
  col    = pixel % WIDTH
  row    = int(pixel / WIDTH)
  a_fact = 1 - (pixel * p_fact)
}

{
  # TRANSFORM HERE
  alpha *= a_fact
}

# OUTPUT
{
  printf("%04x%04x%04x%04x",
        red, green, blue, alpha)
}

