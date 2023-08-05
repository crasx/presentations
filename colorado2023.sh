set +v

# Set up some environment things
GEOMETRY_RPROMPT=''

# Override ls to give us less info (eg: no owner or modified times)
alias ls="ls -go --time-style='+'"
export GIT_PAGER=cat
alias set-readme="tee README.txt <<- EOF
# About Git
Git is a version control system that is great.
It can be used to track changes to code.
EOF
"
# Create working directory.
rm -rf /tmp/colorado2023;
mkdir /tmp/colorado2023;
cd /tmp/colorado2023;
# Create repository.

git init
# Initialized empty Git repository in /tmp/colorado2023/.git/

# Set author and override commit time so that we get consistent object IDs
export GIT_AUTHOR_DATE=1700000000
export GIT_COMMITTER_DATE=$GIT_AUTHOR_DATE
git config user.name "Foo McBar"
git config user.email "foo@example.com"
git checkout -b main

ls .git
# total 32
# drwxr-x--- 2 4096  branches
# -rw-r----- 1   92  config
# -rw-r----- 1   73  description
# -rw-r----- 1   21  HEAD
# drwxr-x--- 2 4096  hooks
# drwxr-x--- 2 4096  info
# drwxr-x--- 4 4096  objects
# drwxr-x--- 4 4096  refs


echo "Hello World" > README.txt
git add README.txt

git status 
# On branch master
#
# No commits yet
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
# 	new file:   README.txt

git ls-files --stage
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 0	README.txt

ls .git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238 
# -r--r----- 1 28  .git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238


# Object IDs

echo 'Hello World' | git hash-object -w --stdin
# 557db03de997c86a4a028e1ebd3a1ceb225be238

ls .git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238 
# .git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238

git cat-file -p 557db03de997c86a4a028e1ebd3a1ceb225be238        
# Hello World

git cat-file -p 557db0        
# Hello World

git cat-file -p 557d    
# Hello World

# Staging second file

mkdir docroot
echo "Hello World" > docroot/index.html

git add .
git ls-files --stage
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 0	README.txt
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 0	docroot/index.html

git commit -m "My first commit"
# [main (root-commit) 6324ca9] My first commit
#  2 files changed, 2 insertions(+)
#  create mode 100644 README.txt
#  create mode 100644 docroot/index.html

find .git/objects -type f
# .git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238
# .git/objects/ef/bd263bc3503e5ebc193a8051ee264b461f89bf
# .git/objects/3e/e01922c53a547b1f51e86cc935cc93005f6d0e
# .git/objects/63/24ca91555c232c2c72968c9b099f9d809e1710

echo 'Git rules' > README.txt
git add .
git ls-files --stage
# 100644 3ab7ccb93843bd2d542772700310f3aa3fe09710 0	README.txt
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 0	docroot/index.html

git commit -m "My second Commit."
# [main 14b9461] My second Commit.
#  1 file changed, 1 insertion(+), 1 deletion(-)

git cat-file -p 14b9461
# tree 6bab6ce1da88421911654b7e00667cd3d4103033
# parent 6324ca91555c232c2c72968c9b099f9d809e1710
# author Foo McBar <foo@example.com> 1700000000 -0700
# committer Foo McBar <foo@example.com> 1700000000 -0700

# My second Commit.


git cat-file -p 6bab6c
# 100644 blob 3ab7ccb93843bd2d542772700310f3aa3fe09710	README.txt
# 040000 tree efbd263bc3503e5ebc193a8051ee264b461f89bf	docroot


git cat-file -p efbd26
# 100644 blob 557db03de997c86a4a028e1ebd3a1ceb225be238	index.html

git cat-file -p b0bd244
# tree 6bab6ce1da88421911654b7e00667cd3d4103033
# parent ecdbef6df53c34fe1bed6a81df01dcf67f08cb37
# author Matthew Ramir <matthew.ramir@gmail.com> 1700000000 -0700
# committer Matthew Ramir <matthew.ramir@gmail.com> 1700000000 -0700

# My second Commit.

find .git/objects -type f
# .git/objects/c9/110285d550c9069501c971d4e1bcc5f17652d5
# .git/objects/3a/b7ccb93843bd2d542772700310f3aa3fe09710
# .git/objects/e1/cce10baf150e809cfb4ca36ec1e6a0f5bdf939
# .git/objects/6b/ab6ce1da88421911654b7e00667cd3d4103033
# .git/objects/3e/e01922c53a547b1f51e86cc935cc93005f6d0e
# .git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238
# .git/objects/ef/bd263bc3503e5ebc193a8051ee264b461f89bf


git cat-file -p  6bab6ce
# 100644 blob 3ab7ccb93843bd2d542772700310f3aa3fe09710	README.txt
# 040000 tree efbd263bc3503e5ebc193a8051ee264b461f89bf	docroot

git cat-file -p  efbd263bc3503e5ebc193a8051ee264b461f89bf
# 100644 blob 557db03de997c86a4a028e1ebd3a1ceb225be238	index.html
                                   
#######################################
# Refs 
#######################################
git checkout -b feature/my-feature HEAD~1
tee README.txt <<- EOF
# About Git
Git is a version control system that is great.
It can be used to track changes to code.
EOF

git commit -am "Add git description."

tee docroot/index.html <<- EOF
<html>Hello World!</html>
EOF

git commit -am "Update index.html"
# [feature/my-feature e4559a8] Update index.html
#  1 file changed, 1 insertion(+), 1 deletion(-)

cat .git/refs/heads/feature/my-feature
# e4559a86c0c97112355f9d4bfae7e849a37547d1

cat .git/refs/heads/main
# 14b9461af873c97374fc05c5c89dcb5f3feb781d

git tag v1.0.0 6324ca

cat .git/refs/tags/v1.0.0
# 6324ca91555c232c2c72968c9b099f9d809e1710

#######################################
# Merge
#######################################
git checkout main

git merge feature/my-feature
# Auto-merging README.txt
# CONFLICT (content): Merge conflict in README.txt
# Automatic merge failed; fix conflicts and then commit the result.

git diff v1.0.0 feature/my-feature
# diff --git a/README.txt b/README.txt
# index 557db03..5628edc 100644
# --- a/README.txt
# +++ b/README.txt
# @@ -1 +1,3 @@
# -Hello World
# +# About Git
# +Git is a version control system that is great.
# +It can be used to track changes to code.


git diff v1.0.0 main 
# diff --git a/README.txt b/README.txt
# index 557db03..3ab7ccb 100644
# --- a/README.txt
# +++ b/README.txt
# @@ -1 +1 @@
# -Hello World
# +Git rules

cat README.txt 
# <<<<<<< HEAD
# Git rules
# =======
# # About Git
# Git is a version control system that is great.
# It can be used to track changes to code.
# >>>>>>> feature/my-feature

git commit
# U	README.txt
# error: Committing is not possible because you have unmerged files.
# hint: Fix them up in the work tree, and then use 'git add/rm <file>'
# hint: as appropriate to mark resolution and make a commit.
# fatal: Exiting because of an unresolved conflict.

git ls-files --stage
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	README.txt￼
# 100644 3ab7ccb93843bd2d542772700310f3aa3fe09710 2	README.txt
# 100644 5628edcbba9cb527b10954500dd56fa7030ec30c 3	README.txt
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 0	docroot/index.html

#########
# Resolve conflicts
#########
tee README.txt <<- EOF
# About Git
Git is a version control system that is great.
It can be used to track changes to code.
EOF

git add .

git ls-files --stage           
# 100644 5628edcbba9cb527b10954500dd56fa7030ec30c 0	README.txt
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 0	docroot/index.html
 
git commit 
# [main 7c6cef7] Merge branch 'feature/my-feature'

git cat-file -p 7c6cef7
# tree af991bc26d34d346aa0bd214b0a44a49a8c81b7d
# parent 14b9461af873c97374fc05c5c89dcb5f3feb781d
# parent e4559a86c0c97112355f9d4bfae7e849a37547d1
# author Foo McBar <foo@example.com> 1700000000 -0700
# committer Foo McBar <foo@example.com> 1700000000 -0700

# Merge branch 'feature/my-feature'

git tag feature-merged

git checkout main

#######################################
# Cherry-Pick
#######################################

git reset --hard 14b9461a

git cherry-pick e4559a86
# [main 06af49b] Update index.html
#  Date: Tue Nov 14 15:13:20 2023 -0700
#  1 file changed, 1 insertion(+), 1 deletion(-)

git cherry-pick 851b2f3b
# Auto-merging README.txt
# CONFLICT (content): Merge conflict in README.txt
# error: could not apply 851b2f3... Add git description.
# hint: After resolving the conflicts, mark them with
# hint: "git add/rm <pathspec>", then run
# hint: "git cherry-pick --continue".
# hint: You can instead skip this commit with "git cherry-pick --skip".
# hint: To abort and get back to the state before "git cherry-pick",

cat README.txt
# <<<<<<< HEAD
# Git rules
# =======
# # About Git
# Git is a version control system that is great.
# It can be used to track changes to code.
# >>>>>>> fa680de (Add file heading.)

tee README.txt <<- EOF
# About Git
Git is a version control system that is great.
It can be used to track changes to code.
EOF

git add .
git cherry-pick --continue
# [main 9afa5c8] Add git description.
#  Date: Tue Nov 14 15:13:20 2023 -0700
#  1 file changed, 3 insertions(+), 1 deletion(-)


git tag feature-cherry-pick

#######################################
# Rebase
#######################################

git rebase 14b9461a feature/my-feature
# Auto-merging README.txt
# CONFLICT (content): Merge conflict in README.txt
# error: could not apply e3bb5f2... Add git description.
# hint: Resolve all conflicts manually, mark them as resolved with
# hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
# hint: You can instead skip this commit: run "git rebase --skip".
# hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
# Could not apply e3bb5f2... Add git description.

cat README.txt                    
# <<<<<<< HEAD
# Git rules
# =======
# Git is a version control system that is great.
# It can be used to track changes to code.
# >>>>>>> e3bb5f2 (Add git description.)

git rebase --continue 
# [detached HEAD 559226a] Add git description.
#  1 file changed, 2 insertions(+), 1 deletion(-)
# Successfully rebased and updated refs/heads/feature/my-feature.

git tag feature-rebase

