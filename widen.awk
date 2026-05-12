BEGIN { fact = 4 }
function to_dec(v)
{
  return sprintf("%d", "0x" v)
}

function clamp(v)
{
  if (v < 0)      return 0
  if (v > 65535) return 65535
  return int(v)
}

NR == 1 {
  gsub(" ", "")
  print; next}
NR == 2 {
  WIDTH = to_dec($1 $2) * fact
  HEIGHT = to_dec($3 $4)
  gsub(" ", "")
  printf("%08x%08x", WIDTH, HEIGHT)
  next
}

# VARIABLES
{
  red = to_dec($1)
  blue = to_dec($2)
  green = to_dec($3)
  alpha = to_dec($4)

}

{
  # TRANSFORM HERE
}

# OUTPUT
{
  for(i = 1; i <= fact; i++){
    printf("%04x%04x%04x%04x",
        red, green, blue, alpha)
    }
}

