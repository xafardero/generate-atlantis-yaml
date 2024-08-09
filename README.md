# Hello world docker action

This action generates an atlantis.yaml based on the tfvars in your all your folders.


## Example usage


```yaml
on: [push]

jobs:
  atlantis-generator:
    runs-on: ubuntu-latest
    name: Generate atlantis.yaml files
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: atlantis generator action step
        id: atlantis-generator
        uses: xafardero/generate-atlantis-yaml@v0.2
```
