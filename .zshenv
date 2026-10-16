# O /etc/zsh/zshrc do Ubuntu chama compinit antes do ~/.zshrc, com o fpath ainda
# sem o site-functions do brew. O dump sai incompleto e o ~/.zshrc precisa refazer
# tudo: ~500ms por shell. Com esta flag o compinit roda só no ~/.zshrc (~60ms).
skip_global_compinit=1
