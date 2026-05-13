BEGIN { fact = 4; col = 0 }

function to_dec(v)
{
  return sprintf("%d", "0x" v)
}

function clamp(v)
{
  if (v < 0)      return 0
  if (v > 65535)  return 65535
  return int(v)
}

NR == 1 {
  gsub(" ", "")
  print; next
}
NR == 2 {
  WIDTH  = to_dec($1 $2)
  HEIGHT = to_dec($3 $4) * fact
  gsub(" ", "")
  printf("%08x%08x", WIDTH, HEIGHT)
  next
}

{
  r[col] = to_dec($1); g[col] = to_dec($2)
  b[col] = to_dec($3); a[col] = to_dec($4)
  col++

  if (col == WIDTH) {
    for (rep = 1; rep <= fact; rep++)
      for (c = 0; c < WIDTH; c++)
        printf("%04x%04x%04x%04x", r[c], g[c], b[c], a[c])
    col = 0
    delete r; delete g; delete b; delete a
  }
}
