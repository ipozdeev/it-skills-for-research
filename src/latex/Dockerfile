# syntax=docker/dockerfile:1

FROM texlive/texlive

RUN tlmgr install threeparttable

WORKDIR tmp/

COPY template.tex .
