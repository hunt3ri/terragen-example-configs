# terragen-example-configs
This repo contains example configuration files for the Terragen project and associated Terraform Modules

## Terragen

Terragen is a framework for generating and automatically applying Terraform modules to simplify the management of sophisticated Cloud Architectures.

[You can get full details and documentation from the project repo here](https://github.com/hunt3ri/terragen)

## Running examples
Update your AWS information in `./config/sandbox` before running commands below

### Create Infra

#### EC2 Sandbox Example
```commandline
terragen -cd ./config build.debug=False environment.dev.profile=hunter_ops_prod environment.dev.bucket=hunter-ops-tfstate -cn sandbox
```

#### Serverless Example
```commandline
terragen -cd ./config build.debug=False build.infra_shared=pass -cn serverless
```

### Destroy Infra
```commandline
terragen -cd ./config build.debug=False build.infra_shared=destroy build.infra_app=destroy -cn sandbox
terragen -cd ./config build.debug=False build.infra_shared=pass build.infra_app=destroy -cn serverless
```

