local pb = require "pb"
local protoc = require "protoc"

-- for more information see: https://github.com/starwing/lua-protobuf

function dump(o, indent)
  if type(o) == 'table' then
    local s = ''
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. indent .. k .. ': '
      if type(v) == 'table' then
        local st = dump(v, indent .. ' ')
        if string.len(st) > 0 then
          s = s .. '\n' .. st
        end
      else
        s = s .. dump(v, indent) .. '\n'
      end
    end
    return s
  else
    return tostring(o)
  end
end


assert(protoc.new():loadfile "opentelemetry/proto/metrics/v1/metrics.proto")

-- print types
-- for name in pb.types() do
--   print(name)
-- end

local data = {}

local bytes = assert(pb.encode(".opentelemetry.proto.metrics.v1.MetricsData", data))
print(pb.tohex(bytes))

local data2 = assert(pb.decode(".opentelemetry.proto.metrics.v1.MetricsData", bytes))

print(dump(data2, ''))