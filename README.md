# Generate Atlantis yaml action

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


# Local testing

```bash
# Build the docker image
docker build -t generate-atlantis-yaml .
# Run on the folder you want to try it
docker run --rm -it -v "$(pwd):/src" generate-atlantis-yaml
```
