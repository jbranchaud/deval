# DEVAL

a project that sets up other projects for evaluation by DECAF

## Environment Setup

There are two different ways to get your environment setup to work with
DEVAL. It involves adding a couple environment variables to your system so
that DEVAL knows where to look for certain stuff. Namely, you are going to
need to set `$DEVAL` and `$DEVALSUB` for your environment.

The `$DEVAL` variable is the top-level directory for the DEVAL project.
The `$DEVALSUB` variable specifies the directory that will be used to by DEVAL
as the top-level directory for
setting up all of the subjects for evaluation. So, if you decide to invoke
the setup script for Example1, it will setup Example1 in the `$DEVALSUB`
directory that you have specified.

### Manually Export Environment Variables

Set the environment variable for the location of DEVAL and the DEVAL subjects:

    export DEVAL=/absolute/path/for/deval
    export DEVALSUB=/absolute/path/for/deval/devalsub

### Add Environment Variables to Bash/Zsh Configuration (preferred)

Rather than typing in the above environment variables manually and making
sure they are always set, you can just add them to your `bash` or `zsh`
configurations so that they are always set for your environment. To do this,
go to your home directory, find the `.bashrc` or `.zshrc` file depending on
which shell environment you prefer, open it up, and add the following lines
to that file:

    export DEVAL=/absolute/path/for/deval
    export DEVALSUB=/absolute/path/for/deval/devalsub

## Buiding a Scenario

In order to quickly generate a scenario, there is some information that
needs to be specified and a few configuration files that need to be created.

### Specifying the Directory Structure

Creating a directory structure for the example and/or scenario is tedious to
do manually. To expedite this part of the process, we have a script,
`dirify.py`, that will generate a directory structure as specified in a YAML
file.

If you want to create a directory structure that looks like this:

    Example
    +-scenario1/
      +-base/
      | +-src/
      | +-bin/
      +-source1/
      | +-src/
      | +-bin/
      +-target1/
      | +-src/
      | +-bin/
      +-config1/
        +-source1/
        | +-astdiff/
        | +-dotfiles/
        +-target1/
          +-astdiff/
          +-dotfiles/

You are going to need to create a YAML file that specifies that structure,
similar to this:

    ---
    DirectoryStructure:
    - base: "$DEVALSUB"
      structure:
      - name: "Example"
        subs:
        - name: "scenario1"
          subs:
          - name: "base"
            subs:
            - name: "src"
            - name: "bin"
          - name: "source1"
            subs:
            - name: "src"
            - name: "bin"
          - name: "target1"
            subs:
            - name: "src"
            - name: "bin"
          - name: "config1"
            subs:
            - name: "source1"
              subs:
              - name: "astdiff"
              - name: "dotfiles"
            - name: "target1"
              subs:
              - name: "astdiff"
              - name: "dotfiles"
    ...

The `base` key is associated with the directory that this directory
structure should be based in. The `structure` key is associated with a
nested list that represents the directory structure to be created.

Though this configuration file may seem a bit verbose, it can easily be
copied and reused because the directory structure for most examples is
almost identical. For instance, to create one for Example2, I simple copy
the YAML file and replace `- name: "Example"` with `- name: "Example2"`.

To run the script and generate the directory structure:

    python dirify.py exampleconfig.yaml
