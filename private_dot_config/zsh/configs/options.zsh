# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# Timezones
export TZ_LIST='America/Los_Angeles,Coast;America/New_York,Office;Asia/Calcutta,India;Etc/UTC,Global'

# Charset
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
