GEOMETRY_RPROMPT=''

rm -rf /tmp/midcamp2023;
mkdir /tmp/midcamp2023;
cd /tmp/midcamp2023;

git checkout -b main

git init

ls -al .git
# Total 44
# drwxr-x--- 7 crasx crasx 4096 Apr 24 19:34 .
# drwxr-x--- 3 crasx crasx 4096 Apr 24 19:34 ..
# drwxr-x--- 2 crasx crasx 4096 Apr 24 19:34 branches
# -rw-r----- 1 crasx crasx   92 Apr 24 19:34 config
# -rw-r----- 1 crasx crasx   73 Apr 24 19:34 description
# -rw-r----- 1 crasx crasx   21 Apr 24 19:34 HEAD
# drwxr-x--- 2 crasx crasx 4096 Apr 24 19:34 hooks
# -rw-r----- 1 crasx crasx  112 Apr 24 19:34 index
# drwxr-x--- 2 crasx crasx 4096 Apr 24 19:34 info
# drwxr-x--- 5 crasx crasx 4096 Apr 24 19:34 objects
# drwxr-x--- 4 crasx crasx 4096 Apr 24 19:34 refs


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

mkdir docroot
echo "Hello World" > docroot/index.html
git add .
git ls-files --stage
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 0	README.txt
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 0	docroot/index.html


# Setting author date gives us a consistent commit hash 
export GIT_AUTHOR_DATE=1700000000
export GIT_COMMITTER_DATE=$GIT_AUTHOR_DATE

git commit -m "My first commit"
# [main (root-commit) ecdbef6] My first commit
#  2 files changed, 2 insertions(+)
#  create mode 100644 README.txt
#  create mode 100644 docroot/index.html

ls .git/objects/ec/dbef6df53c34fe1bed6a81df01dcf67f08cb37

# ecdbef6df53c34fe1bed6a81df01dcf67f08cb37

git cat-file -p ecdbef6
# tree 3ee01922c53a547b1f51e86cc935cc93005f6d0e
# author Matthew Ramir <matthew.ramir@gmail.com> 1700000000 -0700
# committer Matthew Ramir <matthew.ramir@gmail.com> 1700000000 -0700

# My first commit

git cat-file -p 3ee0192
# 100644 blob 557db03de997c86a4a028e1ebd3a1ceb225be238	README.txt
# 040000 tree efbd263bc3503e5ebc193a8051ee264b461f89bf	docroot

git cat-file -p efbd263
# 100644 blob 557db03de997c86a4a028e1ebd3a1ceb225be238	index.html

echo 'Git rules' > README.txt
git add .
git ls-files --stage
# 100644 3ab7ccb93843bd2d542772700310f3aa3fe09710 0	README.txt
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 0	docroot/index.html

git commit -m "My second Commit."
# [main b0bd244] My second Commit.
#  1 file changed, 1 insertion(+), 1 deletion(-)

git cat-file -p b0bd244
# tree 6bab6ce1da88421911654b7e00667cd3d4103033
# parent ecdbef6df53c34fe1bed6a81df01dcf67f08cb37
# author Matthew Ramir <matthew.ramir@gmail.com> 1700000000 -0700
# committer Matthew Ramir <matthew.ramir@gmail.com> 1700000000 -0700

# My second Commit.


git cat-file -p  6bab6ce
# 100644 blob 3ab7ccb93843bd2d542772700310f3aa3fe09710	README.txt
# 040000 tree efbd263bc3503e5ebc193a8051ee264b461f89bf	docroot

git cat-file -p  efbd263bc3503e5ebc193a8051ee264b461f89bf
# 100644 blob 557db03de997c86a4a028e1ebd3a1ceb225be238	index.html
                                   
#######################
# Refs 

git checkout -b branchA
# Switched to a new branch 'branchA'

cat .git/refs/heads/branchA
# b0bd24491f261bda70264b40adcc5383477a870c

git tag v1.0.0 branchA
cat .git/refs/tags/v1.0.0
# b0bd24491f261bda70264b40adcc5383477a870c

git checkout -b branchB
# Switched to a new branch 'branchB'

git reset --hard HEAD~1
cat .git/refs/heads/branchB
# ecdbef6df53c34fe1bed6a81df01dcf67f08cb37

echo 'Conflicting text'  | git hash-object -w --stdin
# 8fa1d98c80e663f1bf180e563f9d17d0bce70c9a

echo 'Conflicting text' > README.txt
git diff 
# diff --git a/README.txt b/README.txt
# index 557db03..8fa1d98 100644
# --- a/README.txt
# +++ b/README.txt
# @@ -1 +1 @@
# -Hello World
# +Conflicting text

git diff branchA 
# diff --git a/README.txt b/README.txt
# index 3ab7ccb..8fa1d98 100644
# --- a/README.txt
# +++ b/README.txt
# @@ -1 +1 @@
# -Git rules
# +Conflicting text



git add .
git commit -m "Causing trouble."
# [branchB eaecc4c] Causing trouble.
# 1 file changed, 1 insertion(+), 1 deletion(-)

git log --graph --all --oneline
# * b0bd244 (main, branchA) My second Commit.
# | * e88ba8e (HEAD -> branchB) Causing trouble.
# |/  
# * ecdbef6 My first commit


git diff 

git merge branchA
# Auto-merging README.txt
# CONFLICT (content): Merge conflict in README.txt
# Automatic merge failed; fix conflicts and then commit the result.

cat README.txt 
# <<<<<<< HEAD
# Conflicting text
# =======
# Git rules
# >>>>>>> branchA

# Resolve conflicts
echo 'Git rules' > README.txt
git add .
git commit  
# [branchB db3da6d] Merge branch 'branchA' into branchB

git cat-file -p db3da6d
# tree 5ebf97c32a6c986419d29f4809f4bd7540f5d570
# parent e88ba8e97c49f45d144868839c3f104a4d78c7a0
# parent b0bd24491f261bda70264b40adcc5383477a870c
# author Matthew Ramir <matthew.ramir@gmail.com> 1700000000 -0700
# committer Matthew Ramir <matthew.ramir@gmail.com> 1700000000 -0700

# Merge branch 'branchA' into branchB



#####

cat .git/refs/heads/mybranch
# 02963a68bca569aecee8d8b1a8dca8c72f4ac593

cat .git/refs/tags/mytag
# 02963a68bca569aecee8d8b1a8dca8c72f4ac593


 git merge foo2 --no-ff

git cat-file -p 306b607
# tree 5ac9c69c561a5658633cc7f6be3df29050663fcb
# parent 2b1b1576dc42aff19e40dce2e6df6210b20de7a0
# parent 1e9e652718d1fb34691b02abb375a29077e7a41f
# author Matthew Ramir <matthew.ramir@gmail.com> 1681135566 -0600
# committer Matthew Ramir <matthew.ramir@gmail.com> 1681135566 -0600
#
# Merge branch 'foo2'

git checkout -b mybranch
git tag mytag
