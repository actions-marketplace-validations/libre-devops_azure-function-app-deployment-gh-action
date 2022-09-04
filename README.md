# Libre DevOps - Azure Terraform GitHub Action

Hello :wave:

```yaml
# action.yml
name: 'Libre DevOps - Deploy Azure Function App -  GitHub Action'
description: 'The heavily opinionated Libre DevOps Action to deploy an Azure function app.'
author: "Craig Thacker <craig@craigthacker.dev>"
branding:
  icon: 'terminal'
  color: 'red'

inputs:
  code-path:
    description: 'The absolute path in Linux format to your code code'
    required: true

  code-client-id:
    description: 'The client id needed for az login'
    required: true

  code-client-secret:
    description: 'The client secret needed for az login'
    required: true

  code-tenant-id:
    description: 'The tenant id needed for az login'
    required: true

  code-app-cmd:
    description: 'The core function command you want to run'
    required: true

runs:
  using: 'docker'
  image: 'Dockerfile'
  args:
    - ${{ inputs.code-path }}
    - ${{ inputs.code-client-id }}
    - ${{ inputs.code-client-secret }}
    - ${{ inputs.code-tenant-id }}
    - ${{ inputs.code-app-cmd }}

```