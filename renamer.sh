#!/bin/bash

# Script to dunk the horrible names stable diffusion outputs for a whole directory. You'll likely not be able to use gmcv without doing this.
# Careful using it, as it most likely will remove the metadata for the .png (can't inspect it to reread your prompts, config, etc).

for f in ./*.png; do
  mv -n "$f" $RANDOM".png"
done
