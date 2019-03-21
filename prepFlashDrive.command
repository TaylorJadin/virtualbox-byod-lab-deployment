prevname=CSFall2018
name=CSspring19

diskutil rename $prevname $name
rsync -aP --stats --human-readable --exclude '.Spotlight-V100'  ~/Desktop/$name/ /Volumes/$name --delete