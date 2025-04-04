FROM sharelatex/sharelatex:latest

RUN curl -fsSL -O "https://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh" && sh update-tlmgr-latest.sh -- --upgrade && rm -f update-tlmgr-latest.sh && \
    export TEXLIVE_PATH=/usr/local/texlive && \
    ls -la "${TEXLIVE_PATH}" && \
    export TEXLIVE_VERSION="$(find "${TEXLIVE_PATH}" -type d -name "2*" -printf "%f\n" | tail -1)" && \
    export PATH="${PATH}:${TEXLIVE_PATH}/${TEXLIVE_VERSION}/bin/x86_64-linux" && \
    echo "${PATH}" && \
    tlmgr path add && \
    tlmgr update --self --all && \
    luaotfload-tool -fu && \
    tlmgr path add && \
    tlmgr install scheme-full && \
    luaotfload-tool -fu && \
    tlmgr path add


#  Install the translate-shell binary for automatic translation
RUN apt-get update \
&&  apt-get install -y \
# trans requires gawk and hexdump (provided by bsdmainutils)
gawk bsdmainutils \
&&  wget  -O /usr/bin/trans https://git.io/trans \
&&  chmod +x /usr/bin/trans