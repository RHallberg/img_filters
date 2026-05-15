BEGIN {
  MAX_COLOR = 65535
  srand()
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
  gsub(" ", "")
  printf("%08x%08x", WIDTH, HEIGHT)
  next
}

# VARIABLES
{
  red = to_dec($1)
  green = to_dec($2)
  blue = to_dec($3)
  alpha = to_dec($4)

}

NR % 4 == 0 {
  red = MAX_COLOR
  green = MAX_COLOR
  blue = MAX_COLOR
}

NR % (int(rand() * 4) +1 ) == 0 {
  red = clamp(red * int(rand()) * 5)
  blue = clamp(blue * int(rand()))
  green = clamp(green * int(rand()))
}

# OUTPUT
{
  printf("%04x%04x%04x%04x",
        red, green, blue, alpha)
}

