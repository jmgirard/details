-- dtext shortcode 
function dtext(args, kwargs, meta)
  local function buildDetails(text, summary, open)
    local details = {
      '<p>',
      '<details' .. open .. '>',
      '<summary>' .. summary .. '</summary>',
      '<blockquote>' .. text .. '</blockquote>',
      '</details>',
      '</p>'
    }
    return table.concat(details, "")
  end
  local text = pandoc.utils.stringify(args[1] or 'Add content here.')
  local summary = (#kwargs["summary"] > 0) and kwargs["summary"] or "Details"
  local open = ""
  if table.concat(args, " ", 2):find("open") then
    open = " open"
  end
  local output = buildDetails(text, summary, open)
  if quarto.doc.isFormat("html:js") then
    return pandoc.RawInline('html', output)
  else 
    return pandoc.Null()
  end
end

-- dstart shortcode
function dstart(args, kwargs, meta)
  local function buildDetails(summary, open)
    local details = {
      '<p>',
      '<details' .. open .. '>',
      '<summary>' .. summary .. '</summary>',
      '<blockquote>'
    }
    return table.concat(details, "")
  end
  local summary = (#kwargs["summary"] > 0) and kwargs["summary"] or "Details"
  local open = ""
  if table.concat(args, " "):find("open") then
    open = " open"
  end
  local output = buildDetails(summary, open)
  if quarto.doc.isFormat("html:js") then
    return pandoc.RawInline('html', output)
  else 
    return pandoc.Null()
  end
end

-- dstop shortcode
function dstop(args, kwargs, meta)
  local output = table.concat({'</blockquote>', '</details>', '</p>'}, "")
  if quarto.doc.isFormat("html:js") then
    return pandoc.RawInline('html', output)
  else 
    return pandoc.Null()
  end
end
