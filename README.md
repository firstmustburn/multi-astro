# multi-astro

This is the static site generator for multiple Astro websites in the same repo.  It uses a
dockerized build environment for consistent output across a development team and CI.  It uses the
excellent Task tool for standardizing and automating common tasks.

## Reference

The [Astro publish to NPM docs](https://docs.astro.build/en/reference/publish-to-npm/) was a useful
resource for setting this up.

## Development Quickstart

Install:
- task: https://taskfile.dev/
- docker: https://docs.docker.com/engine/install/
  - or for windows:
    - WSL: https://learn.microsoft.com/en-us/windows/wsl/install
    - docker destop for windows: https://www.docker.com/products/docker-desktop/


Build the local dev image and run a terminal:

```
task build-image
task env-run
```

To start an additional terminal, use:

```
task env-term
```

In the Docker container, do:

```
yarn install
```

then run site1:

```
cd site1
yarn run dev
```

Then open the site locally at: http://localhost:8000

## VsCode and WSL

If you're running in Windows, then install the the 
[DevContainers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) 
and use the option "Connect to WSL" to relaunch vscode from WSL.  Then go to the
extensions tab and select any extensions you want to install in your remote execution environment.
For this project, you at least need the 
[Astro extension](https://marketplace.visualstudio.com/items?itemName=astro-build.astro-vscode)

If you don't do this, the intellisense will not work because Windows can't follow the symlinks that
yarn creates for local packages in the node_modules directories for each package.