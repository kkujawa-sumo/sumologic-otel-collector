local pb = require "pb"
local protoc = require "protoc"

function process(bytesData)
    assert(protoc.new():loadfile "opentelemetry/proto/metrics/v1/metrics.proto")
    local data = assert(pb.decode(".opentelemetry.proto.metrics.v1.MetricsData", bytesData))
    -- print(require "serpent".block(data))

    if type(data) == 'table' then
      resourceMetrics = data["resource_metrics"]
      for kResourceMetrics, vResourceMetrics in pairs(resourceMetrics) do
        libraryMetrics = vResourceMetrics["instrumentation_library_metrics"]
        for kLibraryMetrics, vLibraryMetrics in pairs(libraryMetrics) do
          metrics = vLibraryMetrics["metrics"]
          for kMetrics, vMetrics in pairs(metrics) do
            dataPoints = vMetrics["sum"]["data_points"]
            for kDataPoints, vDataPoints in pairs(dataPoints) do
              dataPoint = vDataPoints
              -- change startTimestamp
              dataPoint["start_time_unix_nano"] = 0
              -- change value
              dataPoint["as_double"] = 789
              -- add attribute
              dataPoint["attributes"]["lua"] = "true"
            end
          end
        end
      end
    end

    encoded = pb.encode(".opentelemetry.proto.metrics.v1.MetricsData", data)
    return pb.tohex(encoded)
end

-- function process(data)
--   return pb.tohex(data)
-- end