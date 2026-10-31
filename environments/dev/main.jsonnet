// environments/dev/main.jsonnet
local hello = import 'hello.libsonnet';
hello.new({ replicas: 2 })
