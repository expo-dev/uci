HILITE = {
  'eof'       => :const,
  'empty'     => :const,
  'none'      => :const,

  'break'     => :kwd,
  'def'       => :kwd,
  'error'     => :kwd,
  'let'       => :kwd,
  'mut'       => :kwd,
  'return'    => :kwd,
  'type'      => :kwd,
  'violation' => :kwd,

  'else'      => :flow,
  'if'        => :flow,
  'match'     => :flow,
  'repeat'    => :flow,
  'then'      => :flow,
  'while'     => :flow,

  'not'       => :func,
  'and'       => :func,
  'or'        => :func,
}

def format(text)
  HILITE.each do |k, c|
    text.gsub!(/(?<![a-zA-Z_])#{k}(?![a-zA-Z_!?])/, "\\#{c}{#{k}}")
  end
  # text.gsub!(/(?<![a-zA-Z0-9])([a-zA-Z_!?]+)\(/) { '\func{' + $1 + '}\pt(' }
  # text.gsub!(/(?<=[a-zA-Z0-9])\[/, '\pt[')
  text.gsub!(/(?<![a-zA-Z0-9])([a-zA-Z_!?]+)\(/) { '\func{' + $1 + '}(' }
  text.gsub!(/@([a-z_!?]+)/) { '\func{' + $1 + '}' }
  text.gsub!(/'([a-z][a-z0-9_]*)/, '\var{\1}')
  text.gsub!(/'([0-9][0-9_]*)/, '\liter{\1}')
  text.gsub!(/`([0-9][a-fA-F0-9_]*)/, '\liter{\hex{\1}}')
  # text.gsub!(/( )+:( )+/, '\hskip0.5\spaceskip:\hskip0.5\spaceskip ')
  text.gsub!(/<-( )?/) { '\gets' + (($1.nil?) ? '' : '\ ') }
  text.gsub!(/->( )?/) { '\to'   + (($1.nil?) ? '' : '\ ') }
  text.gsub!(/=>( )?/) { '\then' + (($1.nil?) ? '' : '\ ') }
  text.gsub!(/ +\| +/, '\hskip0.5\spaceskip|\hskip0.5\spaceskip ')
  # text.gsub!('...', '\dt ...\dt ')
  # text.gsub!(?_, '\pt ')
  text.gsub!(?_, '\hskip0.5\spaceskip ')
  text.gsub!(?!, '{\ifw !}')

  text = text.lines.map(&:rstrip)
  text.shift while (not text[ 0].nil?) and text[ 0].empty?
  text.pop   while (not text[-1].nil?) and text[-1].empty?

  if text.length == 1
    puts '{\fw\fs\parskip=0pt\strut' + text[0] + '}'
    return
  end

  out = [
    '{\fw\fs',
    '  \parskip=0pt',
    '  \obeylines'
  ]

  text.each do |ln|
    indent = (ln.length - ln.lstrip.length) / 2
    out << '  ' + '\strut' + '\tab'*indent + ' ' + ln.strip
  end

  out << '}'

  puts(out.join(?\n))
end
