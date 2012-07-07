# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias c='clear'
alias q='exit'
alias ms='chmod 744'
alias relaylogin='ssh zhengwei04@relay01.baidu.com'
alias testlogin='ssh img@cq01-news-rdtest01.vm.baidu.com'

export PATH=$PATH$:.
export t1=img@cq01-news-rdtest01.vm.baidu.com
export r1=zhengwei04@relay01.baidu.com

mkdir -p ~/.trash
alias rm=trash
alias r=trash
alias rl='ls ~/.trash'
alias ur=undelfile

undelfile()
{
	mv -i ~/.trash/$@ ./
}
trash()
{
	mv $@ ~/.trash/
}
cleartrash()
{
	read -p "clear sure?[n]:" confirm
	[ $confirm == 'y' ] || [ $confirm == 'Y' ] && /bin/rm -rf ~/.trash/*
}

declare -x LS_COLORS="no=00:fi=00:di=01;36:ln=02;36:pi=40; /
33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37; /
41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00; /
32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00; /
32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00; /
31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00; /
31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00; /
31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00; /
35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"
