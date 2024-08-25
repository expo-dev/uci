Tau = Math::PI * 2

def linearize(x)
  return ((x + 0.055) / 1.055)**2.4 if x > 0.04045
  return x / 12.92
end

def delinearize(x)
  return 1.055 * x**(1.0/2.4) - 0.055 if x > 0.0031308
  return 12.92 * x
end

def srgb_to_oklab(r, g, b)
  r = linearize(r)
  g = linearize(g)
  b = linearize(b)

  l = 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b;
  m = 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b;
  s = 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b;

  l_ = Math::cbrt(l);
  m_ = Math::cbrt(m);
  s_ = Math::cbrt(s);

  return [
    0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_,
    1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_,
    0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_,
  ]
end

def oklab_to_srgb(l, a, b)
  l_ = l + 0.396_337_777_4 * a + 0.215_803_757_3 * b
  m_ = l - 0.105_561_345_8 * a - 0.063_854_172_8 * b
  s_ = l - 0.089_484_177_5 * a - 1.291_485_548_0 * b

  l = l_ * l_ * l_
  m = m_ * m_ * m_
  s = s_ * s_ * s_

  return [
    delinearize(+4.076741662_1 * l - 3.3077115913 * m + 0.2309699292 * s),
    delinearize(-1.268438004_6 * l + 2.6097574011 * m - 0.3413193965 * s),
    delinearize(-0.004196086_3 * l - 0.7034186147 * m + 1.7076147010 * s),
  ]
end

def ab_to_ch(a, b)
  c = Math::sqrt(a*a + b*b)
  h = Math::atan2(b, a)
  h += Tau if h < 0
  h -= Tau if h > Tau
  return [c, h]
end

def ch_to_ab(c, h)
  a = c * Math::cos(h)
  b = c * Math::sin(h)
  return [a, b]
end

#~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

def debug_rgb(r, g, b)
  rgb1   =        [r, g, b].map {|x| x.round(3).to_s }.join(', ')
  rgb255 =  ?(  + [r, g, b].map {|x| (x * 255).round.to_s }.join(', ') + ?)
  rgbx   = '\#' + [r, g, b].map {|x| (x * 255).round.to_s(16) }.join

  l, a, b = srgb_to_oklab(r, g, b)
  c, h = ab_to_ch(a, b)
  h = h / Tau * 360
  lch1 = [l.round(3), c.round(3), h.round(1)].map(&:to_s).join(', ')

  print "{\\caps rgb} #{rgb1} #{rgb255} #{rgbx} $\\to$ {\\caps lch} #{lch1}"
end

def debug_lch(l, c, h)
  lch1 = [l.round(3), c.round(3), h.round(1)].map(&:to_s).join(', ')

  rgb = oklab_to_srgb(l, *ch_to_ab(c, h * Tau / 360))
  rgb1   =        rgb.map {|x| x.round(3).to_s }.join(', ')
  rgb255 =  ?(  + rgb.map {|x| (x * 255).round.to_s }.join(', ') + ?)
  rgbx   = '\#' + rgb.map {|x| (x * 255).round.to_s(16) }.join

  print "{\\caps rgb} #{rgb1} #{rgb255} #{rgbx} $\\gets$ {\\caps lch} #{lch1}"
end

def lch(l, c, h)
  rgb = oklab_to_srgb(l, *ch_to_ab(c, h * Tau / 360))
  return '0 0 0' if rgb.any? {|x| x < 0 || 1 < x }
  return rgb.map {|x| x.round(4).to_s.ljust(6, ?0) }.join(' ')
end
