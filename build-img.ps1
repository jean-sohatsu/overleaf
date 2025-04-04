
$OVERLEAF_LATEST = "sharelatex/sharelatex"

docker build `
  --build-arg BUILDKIT_INLINE_CACHE=1 `
  --progress=plain `
  --cache-from $OVERLEAF_LATEST `
  --file Dockerfile `
  --tag "my_overleaf" `
  .