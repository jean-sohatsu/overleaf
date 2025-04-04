# Set the MONOREPO_ROOT and current working directory
$MONOREPO_ROOT = "../"
$HERE = Get-Location

# Get the current Git commit hash and branch name
$MONOREPO_REVISION = git rev-parse HEAD
$BRANCH_NAME = "latest" #git rev-parse --abbrev-ref HEAD

# Set the environment variables for Docker image tags
$OVERLEAF_BASE_BRANCH = "sharelatex/sharelatex-base:$BRANCH_NAME"
$OVERLEAF_BASE_LATEST = "sharelatex/sharelatex-base"
$OVERLEAF_BASE_TAG = "sharelatex/sharelatex-base:$BRANCH_NAME-$MONOREPO_REVISION"
$OVERLEAF_BRANCH = "sharelatex/sharelatex:$BRANCH_NAME"
$OVERLEAF_LATEST = "sharelatex/sharelatex"
$OVERLEAF_TAG = "sharelatex/sharelatex:$BRANCH_NAME-$MONOREPO_REVISION"

# Copy .dockerignore to the MONOREPO_ROOT
Copy-Item ".dockerignore" -Destination $MONOREPO_ROOT

# Run the Docker build command
#docker build `
#  --build-arg BUILDKIT_INLINE_CACHE=1 `
#  --progress=plain `
#  --file "Dockerfile-base" `
#  --pull `
#  --cache-from $OVERLEAF_BASE_LATEST `
#  --cache-from $OVERLEAF_BASE_BRANCH `
#  --tag $OVERLEAF_BASE_TAG `
#  --tag $OVERLEAF_BASE_BRANCH `
#  $MONOREPO_ROOT

docker build `
  --build-arg BUILDKIT_INLINE_CACHE=1 `
  --progress=plain `
  --build-arg OVERLEAF_BASE_TAG `
  --build-arg MONOREPO_REVISION `
  --cache-from $OVERLEAF_LATEST `
  --cache-from $OVERLEAF_BRANCH `
  --file Dockerfile `
  --tag $OVERLEAF_BRANCH `
  $MONOREPO_ROOT
#  --tag $OVERLEAF_TAG `