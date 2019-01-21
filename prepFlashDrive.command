diskutil rename CompSci18 CSFall2018
rsync -aP --stats --human-readable --exclude '.Spotlight-V100'  ~/Desktop/CSFall2018/ /Volumes/CSFall2018 --delete