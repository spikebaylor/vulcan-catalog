How I created the giant `chaos.yaml` file:

```
curl -sSL https://mirrors.chaos-mesh.org/v2.7.2/install.sh | bash -s -- --template --local kind > chaos.yaml
```

You will get a error for "metadata annotations too large" for 3 of the CRDs in that YAML file. You need to go to each one and delete the giant (1000s of lines) OpenAPI schema definitions.
