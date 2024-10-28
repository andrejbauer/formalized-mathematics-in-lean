#!/bin/bash
jupyter-book build --all . && \
rsync -l -e ssh -r --delete -v _build/html/ andrej@lisa.andrej.com:/var/www/andrej.com/zapiski/MAT-FORMATH-2024/book/
