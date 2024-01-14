git clone -b b2d12cb3-qa-into-master --single-branch git@gitlab.com: b2d12cb3-qa-into-master <project >.git
git clone -b qa --single-branch git@gitlab.com: qa <project >.git
git push --force
git --no-ff

git reset -hard $COMMIT
# View remote URLs
git remote -v
# Add / delete remote origin
git remote set-url --push origin git@ <new-repository >.git
git remote set-url --delete origin git@ <old-repository >.git

git reset -hard <commit>

git push origin --delete <tagname>
git show <tagname>
git tag -d <tagname>
git tag -a <tagname> -m ‘Version 1.0’
git tag

git push origin --tags
