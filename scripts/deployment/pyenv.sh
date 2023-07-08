curl https://pyenv.run | bash


echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)" ' >> ~/.bashrc

source ~/.bashrc

pyenv install 3.11
pyenv global 3.11
