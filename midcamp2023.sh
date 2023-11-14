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
                                   
#######################
# Refs 

cat .git/refs/heads/branchA
# cccccc

cat .git/refs/heads/branchB
# eeeeee

git checkout -b branchC dddddd
git tag v1.0.0 dddddd

cat .git/refs/tags/v1.0.0
# dddddd

git checkout -b branchA
# Switched to a new branch 'branchA'

cat .git/refs/heads/branchA
# b0bd24491f261bda70264b40adcc5383477a870c

git tag v1.0.0 branchA
cat .git/refs/tags/v1.0.0
# b0bd24491f261bda70264b40adcc5383477a870c


git reset --hard HEAD~1
cat .git/refs/heads/branchB
# ecdbef6df53c34fe1bed6a81df01dcf67f08cb37


git diff aaaaaa branchB
# diff --git a/README.txt b/README.txt
# index 557db0..a4a91cf 100644
# --- a/README.txt
# +++ b/README.txt
# @@ -1 +1 @@
# -Hello World
# +Git rules!


git diff aaaaaa branchA 
# diff --git a/README.txt b/README.txt
# index 557db0..3f303f0d 100644
# --- a/README.txt
# +++ b/README.txt
# @@ -1 +1 @@
# -Hello World
# +Git stinks



git merge branchA
# Auto-merging README.txt
# CONFLICT (content): Merge conflict in README.txt
# Automatic merge failed; fix conflicts and then commit the result.

cat README.txt 
# <<<<<<< HEAD
# Git rules!
# =======
# Git stinks
# >>>>>>> branchA

git ls-files --stage
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	README.txt
# 100644 3f303f0d0de3cce5ce68dc6e39733fe4bb7c7409 2	README.txt
# 100644 a4a91cff6860bf14afa570c7753e2b83e2ea9350 3	README.txt
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 	0	docroot/index.html

echo "Git rules\!" > README.txt
git add .

git ls-files --stage           
# 100644 3f303f0d0de3cce5ce68dc6e39733fe4bb7c7409 0	README.txt
# 100644 557db03de997c86a4a028e1ebd3a1ceb225be238 0	docroot/index.html

 
git commit 
# [branchB ffffff] Merge branch 'branchA'

git cat-file -p ffffff
# tree e9327ec...
# parent cccccc
# parent eeeeee
# author Matthew Ramir <matthew.ramir@gmail.com> 1700000000 -0600
# committer Matthew Ramir <matthew.ramir@gmail.com> 1700000000 -0600

# Merge branch 'branchA'
