#!/bin/bash

d=$(date +%Y%m%d)
oldd=$(grep filename angler.json | cut -d '-' -f 3)
md5=$(md5sum ../out/target/product/angler/lineage-17.1-"${d}"-UNOFFICIAL-angler.zip | cut -d ' ' -f 1)
oldmd5=$(grep '"id"' angler.json | cut -d':' -f 2)
utc=$(grep ro.build.date.utc ../out/target/product/angler/system/build.prop | cut -d '=' -f 2)
oldutc=$(grep datetime angler.json | cut -d ':' -f 2)
size=$(wc -c ../out/target/product/angler/lineage-17.1-"${d}"-UNOFFICIAL-angler.zip | cut -d ' ' -f 1)
oldsize=$(grep size angler.json | cut -d ':' -f 2)
oldurl=$(grep url angler.json | cut -d ' ' -f 8)

# This is where the magic happens


sed -i "s!${oldmd5}! \"${md5}\",!g" angler.json
sed -i "s!${oldutc}! \"${utc}\",!g" angler.json
sed -i "s!${oldsize}! \"${size}\",!g" angler.json
sed -i "s!${oldd}!${d}!" angler.json
echo Enter the new Download URL
read -r url
sed -i "s!${oldurl}!\"${url}\",!g" angler.json
