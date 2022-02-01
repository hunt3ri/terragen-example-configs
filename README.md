# terragen-example-configs
This repo contains example configuration files for the Terragen project and associated Terraform Modules

## Terragen

Terragen is a framework for generating and automatically applying Terraform modules to simplify the management of sophisticated Cloud Architectures.

[You can get full details and documentation from the project repo here](https://github.com/hunt3ri/terragen)

## Running examples
Update your AWS information in `./config/apps` before running commands below

### Create Infra
#### Serverless Example
```commandline
terragen -cd ./config build.debug=False build.infra_shared=pass -cn serverless
```

