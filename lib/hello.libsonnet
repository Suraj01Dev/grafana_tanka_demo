local k = import 'k.libsonnet';

local deployment = k.apps.v1.deployment;
local container = k.core.v1.container;
local port = k.core.v1.containerPort;
local service = k.core.v1.service;

local defaults = {
  name: 'hello',
  image: 'nginx:1.27-alpine',
  replicas: 1,
  port: 80,
};

{
  new(config={})::
    local c = defaults + config;
    {
      deployment: deployment.new(
        name=c.name,
        replicas=c.replicas,
        containers=[
          container.new(c.name, c.image)
          + container.withPorts([port.new(c.port)]),
        ],
      ),
      service: service.new(
        c.name,
        { name: c.name },
        [{ port: c.port, targetPort: c.port }],
      ),
    },
}
