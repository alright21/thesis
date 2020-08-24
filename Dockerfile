FROM debian:buster-slim

WORKDIR /var/local

ENV DEBIAN_FRONTEND noninteractive

# combine into one run command to reduce image size
RUN mkdir -p /usr/share/man/man1 && apt-get update && \
    apt-get install -y perl wget libfontconfig1 fontconfig ghostscript openjdk-11-jre-headless poppler-utils python3-pygments python3-pandocfilters pandoc-citeproc pandoc && \
    wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh  && \
    apt-get clean && ln -s /usr/bin/python3 /usr/bin/python
    
RUN wget https://tech.utugit.fi/soft/tools/veraPDF-apps/files/greenfield-apps-1.17.0-SNAPSHOT.jar -O /validator.jar && \
    echo 'java -cp /validator.jar org.verapdf.apps.GreenfieldCliWrapper --format text -v "$@"' > /root/bin/pdfa-validate && \
    chmod +x /root/bin/pdfa-validate

ENV PATH="${PATH}:/root/bin"

RUN tlmgr update --self && tlmgr install xetex scheme-small && fmtutil-sys --all

# install only the packages you need
RUN tlmgr install adjustbox collectbox biblatex tracklang biblatex-ieee csquotes datetime2 \
    datetime2-english datetime2-finnish biber xstring units lastpage comment \
    fontawesome chessboard skak glossaries datenumber datetime advdate multido todonotes \
    semantic syntax wasysym dashrule titlecaps pdfx ifnextok xmpincl blindtext minted \
    fvextra catchfile includernw algorithm2e shapepar hanging sectionbox euro nag nomencl \
    filecontents zref collection-fontsrecommended collection-fontsextra epstopdf && tlmgr path add
