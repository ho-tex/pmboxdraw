#!/usr/bin/env texlua


module = "pmboxdraw"

installfiles = {
'*.sty',
'pmboxdraw-showcases.tex',
'*.dtx','*.pdf'
}


textfiles = {"README.md"}
unpackfiles = {'pmboxdraw.dtx'}

packtdszip  = true

maxprintline=10000
checkruns = 2

tdslocations={
"doc/latex/pmboxdraw/pmboxdraw.pdf",
"source/latex/pmboxdraw/pmboxdraw.dtx",
"tex/latex/pmboxdraw/pmboxdraw.sty",
"tex/latex/pmboxdraw/pmboxdrawenc.dfu",
}

function update_tag(file,content,tagname,tagdate)

local tagpattern="(%d%d%d%d[-/]%d%d[-/]%d%d) v(%d+[.])(%d+)"
local oldv,newv
if tagname == 'auto' then
  local i,j,olddate,a,b
  i,j,olddate,a,b= string.find(content, tagpattern)
  if i == nil then
    print('OLD TAG NOT FOUND')
    return content
  else
    print ('FOUND: ' .. olddate .. ' v' .. a .. b )
    oldv = olddate .. ' v' .. a .. b
    newv = tagdate .. ' v'  .. a .. math.floor(b + 1)
    print('USING OLD TAG: ' .. oldv)
    print('USING NEW TAG: ' .. newv)
    content=string.gsub(content,"{Version}{" .. oldv,'##OLDV##')
    content=string.gsub(content,oldv,newv)
    content=string.gsub(content,'##OLDV##',"{Version}{" .. oldv)
    content = string.gsub(content,
        '%% \\end{History}',
	'%%   \\begin{Version}{' .. newv .. '}\n%%   \\item Updated\n%%   \\end{Version}\n%% \\end{History}')
    return content
  end
else
  error("only automatic tagging supported")
end

end


