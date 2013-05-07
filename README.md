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
sure they are always set, you can just add them to your `bashrc` or `zshrc`
configurations so that they are always set for your environment. To do this,
go to your home directory, find the `.bashrc` or `.zshrc` file depending on
which shell environment you prefer, open it up, and add the following lines
to that file:

    export DEVAL=/absolute/path/for/deval
    export DEVALSUB=/absolute/path/for/deval/devalsub

