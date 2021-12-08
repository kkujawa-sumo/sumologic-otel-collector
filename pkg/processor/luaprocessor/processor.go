package luaprocessor

import (
	"context"
	"fmt"

	"go.opentelemetry.io/collector/model/pdata"

	glua "github.com/RyouZhang/go-lua"
	"go.opentelemetry.io/collector/model/otlp"
	//metricpb "go.opentelemetry.io/proto/otlp/metrics/v1"
	//"github.com/golang/protobuf/proto"
)

type luaProcessor struct {
	function string
	script   string
}

func newLuaProcessor(cfg *Config) *luaProcessor {
	return &luaProcessor{
		function: cfg.Function,
		script:   cfg.Script,
	}
}

// ProcessMetrics processes metrics
func (lp *luaProcessor) ProcessMetrics(ctx context.Context, md pdata.Metrics) (pdata.Metrics, error) {
	fmt.Println("***Hello from Lua metrics processor***")

	marshaler := otlp.NewProtobufMetricsMarshaler()
	data, err := marshaler.MarshalMetrics(md)
	if err != nil {
		fmt.Println(err)
		return md, err
	}

	fmt.Println("Lua processor, script: ", lp.script, ", function: ", lp.function)
	var res interface{}
	res, err = glua.NewAction().WithScriptPath(lp.script).WithEntrypoint(lp.function).AddParam(data).Execute(context.Background())
	if err != nil {
		fmt.Println(err)
		return md, err
	}
	//fmt.Println("*** lua script returned", res)
	var newMetrics pdata.Metrics
	unmarshaler := otlp.NewProtobufMetricsUnmarshaler()
	newMetrics, err = unmarshaler.UnmarshalMetrics([]byte(*res.(*string)))
	if err != nil {
		fmt.Println(err)
		return md, err
	}
	return newMetrics, err
}

// ProcessTraces processes traces
func (lp *luaProcessor) ProcessTraces(ctx context.Context, md pdata.Traces) (pdata.Traces, error) {
	// TODO: add processor logic here
	fmt.Println("***Hello from Lua traces processor***")

	return md, nil
}

// ProcessLogs processes logs
func (lp *luaProcessor) ProcessLogs(ctx context.Context, md pdata.Logs) (pdata.Logs, error) {
	// TODO: add processor logic here
	fmt.Println("***Hello from Lua logs processor***")

	return md, nil
}
