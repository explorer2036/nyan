#!/bin/bash

ref_name=v1.0.1
version=$(echo ${ref_name} | sed -e 's/v//')
repo_name=nyan
checksums=${repo_name}_${version}_SHA256SUMS
for entry in `ls *.go`; do
zipfile=$(echo $entry | awk -F'/' '{print $NF}')
sha256sum ${zipfile} >> ${checksums}
done
cat ${checksums}

fingerprint=F19257F9F61B6535E586E17145660E624BD48011
gpg --batch --local-user ${fingerprint} --output ${checksums}.sig --detach-sign ${checksums}
gpg --verify ${checksums}.sig ${checksums}