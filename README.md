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
        uses: xafardero/generate-atlantis-yaml@main
      - name: Check for modified files
        id: check_files
        run: |
          # Get the list of modified files
          MODIFIED_FILES=$(git status --porcelain)
          # Check if any files are modified
          if [ -z "$MODIFIED_FILES" ]; then
            echo "No modified files found."
            echo "::set-output name=files_modified::false"
          else
            echo "Modified files detected:"
            echo "$MODIFIED_FILES"
            echo "::set-output name=files_modified::true"
          fi
      - name: Commit and Push Changes
        if: steps.check_files.outputs.files_modified == 'true'
        run: |
          git config --local user.name "github-actions[bot]"
          git config --local user.email "github-actions[bot]@users.noreply.github.com"
          git add atlantis.yaml
          git commit -m "Add atlantis.yaml via GitHub Action"
          git push
```


# Local testing

```bash
# Build the docker image
docker build -t generate-atlantis-yaml .
# Run on the folder you want to try it
docker run --rm -it -v "$(pwd):/src" generate-atlantis-yaml
```
