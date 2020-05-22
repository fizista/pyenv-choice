# pyenv-choice

It allows you to choose which version of Python you will use for a given program name, 
if there are multiple versions of this program.

By default, if the python version is not selected for the command, then an attempt is made to find the command 
in the last python version installed.

## Install

Installing **pyenv-choice** as a pyenv plugin will give you access to the provided behavior.

```sh
$ git clone https://github.com/fizista/pyenv-choice.git ~/.pyenv/plugins/pyenv-choice
```

## Usage

Setting the chosen python version:
```sh
$ pyenv install 3.6.5
$ pyenv install 3.8.1
$ pyenv version
system (set by ...)

$ python3 --version 2>/dev/null
Python 3.8.1

$ pyenv cmd-local python3 3.6.5

$ python3 --version 2>/dev/null
Python 3.6.5
```

Setting the selected python version for the selected command:
```sh
$ pyenv install 3.6.5
$ pyenv install 3.8.1
$ pyenv shell 3.6.5
$ pip install pipenv
$ pyenv shell 3.8.1
$ pip install pipenv
$ pyenv shell --unset

$ pyenv version
system (set by ...)

$ pipenv --version
############################### pyenv-choice #################################
Found multiple pipenv versions. The command was launched from a manually
selected version of the python '3.8.1'.
You can change it with the commands: 
  > pyenv cmd-global pipenv <version>
  > pyenv cmd-local pipenv <version>
##############################################################################

pipenv, version 2018.11.26

$ pyenv cmd-local pipenv 3.6.5
$ pipenv --version
############################### pyenv-choice #################################
Found multiple pipenv versions. The command was launched from a manually
selected version of the python '3.6.5'.
You can change it with the commands: 
  > pyenv cmd-global pipenv <version>
  > pyenv cmd-local pipenv <version>
##############################################################################

pipenv, version 2018.11.26

```




## License
Unless otherwise noted, all files contained within this project are liensed under the MIT opensource license. See the included file LICENSE or visit [opensource.org][] for more information.

[opensource.org]: http://opensource.org/licenses/MIT
