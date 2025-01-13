-- dtext shortcode 
function dtext(args, kwargs, meta)
  local text = pandoc.utils.stringify(args[1])
  local summary = pandoc.utils.stringify(kwargs['summary'])
  local p = pandoc.utils.stringify(kwargs['p'])
  local blockquote = pandoc.utils.stringify(kwargs['blockquote'])
  local class = pandoc.utils.stringify(kwargs['class'])

  output = ''
  if p ~= 'false' then
    output = output .. '<p>'
  end
  
  output = output .. '<details'
  if class ~= '' then
    output = output .. ' class="' .. class .. '"'
  end

  output = output .. ">"
  if summary ~= '' then
    output = output .. '<summary>' .. summary ..'</summary>'
  else
    output = output .. '<summary>Details</summary>'
  end

  if blockquote ~= 'false' then
    output = output .. '<blockquote>'
  end

  output = output .. text

  if blockquote ~= 'false' then
    output = output .. '</blockquote>'
  end

  output = output .. '</details>'

  if p ~= 'false' then
    output = output .. '</p>'
  end

  if quarto.doc.isFormat("html:js") then
    return pandoc.RawInline('html', output)
  else 
    return pandoc.Null()
  end
end

-- dopen shortcode
function dopen(args, kwargs, meta)
  local summary = pandoc.utils.stringify(kwargs['summary'])
  local p = pandoc.utils.stringify(kwargs['p'])
  local blockquote = pandoc.utils.stringify(kwargs['blockquote'])
  local class = pandoc.utils.stringify(kwargs['class'])

  output = ''
  if p ~= 'false' then
    output = output .. '<p>'
  end
  
  output = output .. '<details'
  if class ~= '' then
    output = output .. ' class="' .. class .. '"'
  end

  output = output .. ">"
  if summary ~= '' then
    output = output .. '<summary>' .. summary ..'</summary>'
  end

  if blockquote ~= 'false' then
    output = output .. '<blockquote>'
  end

  if quarto.doc.isFormat("html:js") then
    return pandoc.RawInline('html', output)
  else 
    return pandoc.Null()
  end
end

-- dclose shortcode
function dclose(args, kwargs, meta)
  local p = pandoc.utils.stringify(kwargs['p'])
  local blockquote = pandoc.utils.stringify(kwargs['blockquote'])

  output = ''

  if blockquote ~= '' then
    output = output .. '</blockquote>'
  end

  output = output .. '</details>'

  if p ~= '' then
    output = output .. '</p>'
  end

  if quarto.doc.isFormat("html:js") then
    return pandoc.RawInline('html', output)
  else 
    return pandoc.Null()
  end
end



-- d_o alias
function d_o(...)
  return dopen(...)
end

-- d_c alias
function d_c(...)
  return dclose(...)
end

-- d_t alias
function d_t(...)
  return dtext(...)
end
