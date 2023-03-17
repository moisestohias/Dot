# set -U fish_user_paths $fish_user_paths $HOME/.local/bin

# # Add my scripts: Not needed bc they're already added from the bashrc
# if test -e "$HOME/.scripts"
#     set PATH "$HOME/.scripts:$PATH"
# end

set CurrentWindowWidth $(xrandr | grep primary | awk '{print $4}' | cut -d x -f 1)
set CurrentWindowHight $(xrandr | grep primary | awk '{print $4}' | cut -d x -f 2 | cut -d '+' -f 1)
set CurrentWindowWidthM20 (math $CurrentWindowWidth - 20 )
set CurrentWindowHightM20 (math $CurrentWindowHight - 20 )

set fish_greeting            # Turns off the intro message when pulling up fish shell
# set TERM "xterm-256color"  # Sets the terminal type
# set TERM "xterm-kitty"       # setting TERM to kitty is important for ranger's kitty preview to work
set EDITOR "nvim"            # Sets $EDITOR to vim
set VISUAL "nano"            # Sets $VISUAL to your fav GUI Text Editor

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_user_key_bindings
    fzf_key_bindings
end


function emoji
    # make sure you have .emoji.txt in your home,
    if test -e ~/.emojis.txt
        cat ~/.emojis.txt | fzf | cut -d " " -f 1 | xclip -r -sel clip
    else
        curl -sSL 'https://git.io/JXXO7' > .emojis.txt  
        cat ~/.emojis.txt | fzf | cut -d " " -f 1| xclip -r -sel clip 
    end
end

function get_font
    # This function won't work because there's no consistent url for all fonts.
    set fontName "$(cat ~/.NerdFontNameList.txt | fzf)"
    set CleanFontName "$(echo $fontName| tr -d [:space:])"
    if test -z "$fontName"  # If you don't want to download - No harm
        return 0
    end
    set fontLink "$(echo $fontName.otf | sed -e 's/\s\+/%20/g')"
    if not test  -d ~/.local/share/fonts
        mkdir -p ~/.local/share/fonts
    end
    cd ~/.local/share/fonts
    echo $CleanFontName.otf
    echo https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/$CleanFontName/complete/$fontLink
    # curl -Lo $CleanFontName.otf https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/$fontLink


end


function chwall
    gsettings set org.gnome.desktop.background picture-uri-dark "file:///$(find ~/Pictures/Walls/ -type f| shuf -n 1)"
end

function banner
    figlet -f maxiwi $argv
end

function rbanner
    figlet -f (figlist | shuf -n 1 ) $argv
end


# Fixing fish 'less file.pdf' file
function less
    if type -q pdftotext && string match -iqr '\.pdf$' $argv[1]
        pdftotext $argv[1] - | command less
    else
        command less $argv
    end
end


# fzf magic ================================================================ 
function magic --description "Don't mess with the MONSTERS"
    # rg . | fzf --delimiter : --preview="less {1}" | cut -d ":" -f 1 | awk '{print "\x27" $0 "\x27" }' | xargs -r nvim
    nvim -r "$(rg . | fzf --delimiter : --preview="less {1}" | cut -d ":" -f 1)"
end
function nagic --description "Don't mess with the MONSTERS"
    rg . | fzf --delimiter : --preview="less {1}" | cut -d ":" -f 1 | awk '{print "\x27" $0 "\x27" }' | xargs -r nv
end

function fzfmagic 
    nvim "$(grep -r . | fzf --delimiter : --preview="less {1}" | cut -d ":" -f 1)"
    # grep -r .|fzf|cut -d ":" -f 1 |awk '{print "\x27" $0 "\x27" }'|xargs nvim
    # rg . | fzf --height 60% --reverse| cut -d ":" -f 1 | awk '{print "\x27" $0 "\x27" }' | xargs nvim
end


function GetSubtitle
    yt-dlp $argv --sub-lang en --write-sub --sub-format vtt --convert-subtitles srt --write-auto-sub --skip-download
end

function CleanSRTSubtitle
    grep -Pv '^\d+|^\s*$' $argv | uniq -iu
end

function CleanLatestSRTDownloadedSubtitle
ls *.srt -ct | head -1 | awk '{print "\x27" $0 "\x27"}' | xargs grep -Pv '^\d+|^\s*$' | uniq -iu
end

function fzim
    set files $(fzf --preview='bat -fn {}') && nvim "$files" && clear
    # -c 'if !argc()|quit|endif' quit if no argument is provided
    # nvim -c 'if !argc()|quit|endif' $(fzf --height 60% --reverse | awk '{print "\x27" $0 "\x27" }')  
    # You can do this but it will open vim file explorer 
    # nvim -c 'if !argc()|quit|endif' "$(fzf)" 
end

function fzin
    set files $(fzf --preview='bat -fn {}') && nv "$files" && clear
end

function cd_with_fzf 
    cd ~ && cd "$(find ** -type d -not -path "*/\.*" | fzf --preview="tree -h --du -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)" && clear
end

function open_with_fzf 
    find -type f|fzf -m|xargs -ro -d "\n" xdg-open 2>&- 
end


function sudo --description "replacement for 'sudo !!' command to run last command using sudo"
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end

# Custom function for counting installed programs
function count-installed
    dpkg -l | grep -c '^ii'
end

# Custom function for listing ram hogs
function memhogs
    ps axh -o cmd:15,%mem --sort=-%mem | head
end

# Custom function for listing cpu hogs
function cpuhogs
    ps axh -o cmd:15,%cpu --sort=-%cpu | head
end

# Function to find resolutions of monitors
function resolution
    xrandr | grep \* | sed 's/59.95\*+//g'
end

function hdd --description "Function to print percent used hdd space of home folder"
    df -h /home | grep /dev | awk '{print $3 "/" $5}'
end

function avail --description "Function to see available storage in home folder"
    df -h /home | grep /dev/ | awk '{print $4}'
end


function aptInstall --description "Function to make apt search better"
    apt-cache search '' | sort | cut -d ' ' --fields 1 | fzf --multi --cycle --reverse --preview 'apt-cache show {1}'| xargs -r sudo apt install -y
end
function fapt
    apt-cache search '' | cut -d ' ' --fields 1 | fzf --multi --cycle --reverse --preview 'apt-cache show {1}' | xclip -sel clip
end


# Media Playing ================================================================ 
function fplay
    ffplay -i $argv -v error -x $CurrentWindowWidthM20 -y $CurrentWindowHightM20 -noborder
end
alias fplay "ffplay -v error -x $CurrentWindowWidthM20 -y $CurrentWindowHightM20 -noborder"
alias nplay "fplay -vf negate"

function playMedia
    find $(pwd) -type f | egrep '\.(webm|mkv|mp4|m4a|aac|mp3|wav)$' | awk '{print "\x22" $0 "\x22" }' | sort | xargs -n 1 ffplay -autoexit -v error -x $CurrentWindowWidthM20 -y $CurrentWindowHightM20 -noborder -i 
end

function plaympv --description  "play all media files in the current dir and its nested dir."
    find $(pwd) -type f | awk '{print "\x27" $0 "\x27" }' | sort | xargs mpv
end

function play
   for i in *.$argv
      fplay -autoexit $i
   end
end

### Key Bindings: ======================================================
bind \cd cd_with_fzf
bind \co open_with_fzf
bind \cf fzfmagic

### Abbreviations  ======================================================
# function vim --wraps=nvim --description 'alias vim=nvim' # Don't remember why is this
#   nvim $argv;
# end
abbr v 'nvim'
abbr vim 'nvim'
abbr diff "kitty +kitten diff "
abbr sai "sudo apt install"
abbr sainir "sudo apt install --no-install-recommends"
abbr df 'df -h'
abbr free 'free -g'
abbr reboot 'sudo reboot'
abbr virtnetwork 'sudo virsh net-start default'
abbr p 'ping -aAc 4 192.168.1.1 && ping -aAc 4 google.com '
abbr h 'cd ~/'
abbr n 'cd ~/Documents/Notes'
abbr m 'cd ~/Music/Music'
abbr w 'cd ~/Pictures/Walls'
abbr c 'clear'
abbr r 'ranger .'
abbr rm 'rm -rf'
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr ld 'fd -t d -d 1'
abbr lf 'fd -t f -d 1'
abbr l 'exa --icons --group-directories-first'
abbr ll 'exa --icons --group-directories-first -l'
abbr la 'exa --icons --group-directories-first -a'
abbr ls. 'ls -A | egrep "^\."'
abbr merge 'xrdb -merge ~/.Xresources'
abbr q 'exit'
abbr d 'cd ~/Downloads'
abbr doc 'cd ~/Documents'
abbr grep 'grep --color=auto'
abbr egrep 'egrep --color=auto'
abbr fgrep 'fgrep --color=auto'
abbr .s 'cd ~/.scripts'
abbr pk 'sudo pkill'
# abbr pk 'ps -ef | fzf  | awk '{print $2}' | xargs kill -9'
abbr search 'w3m google.com'
abbr sciv 'sxiv -fbS 1'


# Both of these must be functions; to handle the case where user pass arguments,
# https://stackoverflow.com/questions/29635083/fish-shell-check-if-argument-is-provided-for-function
alias what 'dictl -d fd-eng-ara (cat /usr/share/dict/words | fzf --reverse) | tail -n 2'
alias def 'dictl  (cat /usr/share/dict/words | fzf --reverse)'
alias pallet 'pastel random | pastel mix $(pastel random -n 1) | pastel lighten 0.2 | pastel format | pastel format'
alias printPallet 'pastel color $(cat pallet.txt | tr "#" " " ) | pastel format'
alias arec 'arecord -r 44100 -f S16_LE '
alias fmrec 'ffmpeg -v error -f alsa -i hw:0 '

alias ssc "ffmpeg -f x11grab -video_size 1920x1080 -framerate 30  -i :0.0+0,0 -strict experimental  -v error"
status --is-login; and status --is-interactive; and exec byobu-launcher


